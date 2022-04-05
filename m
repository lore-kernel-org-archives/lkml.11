Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1549C43219
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 10:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358464AbiDEK2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241040AbiDEIco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEB8B7155;
        Tue,  5 Apr 2022 01:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F023960FF5;
        Tue,  5 Apr 2022 08:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075F0C385A2;
        Tue,  5 Apr 2022 08:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147171;
        bh=1P7dqhC2TaTndTPDyXwVbqmJovUDvfg+vmyr+QM2+nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oG+YwcodAkuvv+SoOtZOtr8/Ftqfr9qdFXzq6F/oym7EFlg/6EWZluSjYAUyD2OfK
         anwh01Z2VElSJYzI3xW049oZ8Ob3jiy+gApFHbU+HfzywzPd8lloQYjSunVHnIc3GY
         e30lhDKBV/8NXz68XIQ8pi3qXOLcCu6qQr8r7q1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5.17 1027/1126] rtc: check if __rtc_read_time was successful
Date:   Tue,  5 Apr 2022 09:29:34 +0200
Message-Id: <20220405070437.624806662@linuxfoundation.org>
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

From: Tom Rix <trix@redhat.com>

commit 915593a7a663b2ad08b895a5f3ba8b19d89d4ebf upstream.

Clang static analysis reports this issue
interface.c:810:8: warning: Passed-by-value struct
  argument contains uninitialized data
  now = rtc_tm_to_ktime(tm);
      ^~~~~~~~~~~~~~~~~~~

tm is set by a successful call to __rtc_read_time()
but its return status is not checked.  Check if
it was successful before setting the enabled flag.
Move the decl of err to function scope.

Fixes: 2b2f5ff00f63 ("rtc: interface: ignore expired timers when enqueuing new timers")
Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20220326194236.2916310-1-trix@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/interface.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -804,9 +804,13 @@ static int rtc_timer_enqueue(struct rtc_
 	struct timerqueue_node *next = timerqueue_getnext(&rtc->timerqueue);
 	struct rtc_time tm;
 	ktime_t now;
+	int err;
+
+	err = __rtc_read_time(rtc, &tm);
+	if (err)
+		return err;
 
 	timer->enabled = 1;
-	__rtc_read_time(rtc, &tm);
 	now = rtc_tm_to_ktime(tm);
 
 	/* Skip over expired timers */
@@ -820,7 +824,6 @@ static int rtc_timer_enqueue(struct rtc_
 	trace_rtc_timer_enqueue(timer);
 	if (!next || ktime_before(timer->node.expires, next->expires)) {
 		struct rtc_wkalrm alarm;
-		int err;
 
 		alarm.time = rtc_ktime_to_tm(timer->node.expires);
 		alarm.enabled = 1;


