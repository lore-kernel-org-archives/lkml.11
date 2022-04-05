Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187EFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 07:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiDEHym (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 03:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiDEHr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1697C92311;
        Tue,  5 Apr 2022 00:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9691616D9;
        Tue,  5 Apr 2022 07:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B965EC340EE;
        Tue,  5 Apr 2022 07:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649144700;
        bh=bx4OA99MuLSgu/uivGIVAzDDUaMtJVDBOqgY/wRuEHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3rbG+B2Tag6GGNJZrExzVTyeQjBRBJ6L+gsHXUVeokYXpnjdeuclUX8seS8hdw6+
         jXBXFOSuoIRRsAhhNQ5pC22aTSUqg+jlqcEt4nxN+0jXUCQ6EhnF5QTPq6MkdIaDlG
         nBXki8zbwdNYK7yi+g2vGmQz00r3aEDT7DKkWRIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.17 0100/1126] rtc: mc146818-lib: fix locking in mc146818_set_time
Date:   Tue,  5 Apr 2022 09:14:07 +0200
Message-Id: <20220405070410.504194009@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Jończyk <mat.jonczyk@o2.pl>

commit 811f5559270f25c34c338d6eaa2ece2544c3d3bd upstream.

In mc146818_set_time(), CMOS_READ(RTC_CONTROL) was performed without the
rtc_lock taken, which is required for CMOS accesses. Fix this.

Nothing in kernel modifies RTC_DM_BINARY, so a separate critical section
is allowed here.

Fixes: dcf257e92622 ("rtc: mc146818: Reduce spinlock section in mc146818_set_time()")
Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20220220090403.153928-1-mat.jonczyk@o2.pl
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-mc146818-lib.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -232,8 +232,10 @@ int mc146818_set_time(struct rtc_time *t
 	if (yrs >= 100)
 		yrs -= 100;
 
-	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY)
-	    || RTC_ALWAYS_BCD) {
+	spin_lock_irqsave(&rtc_lock, flags);
+	save_control = CMOS_READ(RTC_CONTROL);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
 		sec = bin2bcd(sec);
 		min = bin2bcd(min);
 		hrs = bin2bcd(hrs);


