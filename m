Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D470CCA48F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 17:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbiFWR7L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 13:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiFWRyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:54:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA28EAD9C5;
        Thu, 23 Jun 2022 10:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52FABB82498;
        Thu, 23 Jun 2022 17:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309B3C3411B;
        Thu, 23 Jun 2022 17:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656004508;
        bh=vPRTMm+R+ACCNBJFw2ofXGsoF9uzS5IfdoIy6DONyu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N7t1PnZFsqfdN+tGqVh5gBPgQEpNkPeelG7w0W5m3XcRTrDxh1b4eVyLyDzbAh1G+
         b7S4+BD1UhibOzKhEIiWEiUZV7B8GAHcrNpeGSqRM+/NdwNb2ZCtzEYxGzyP5qDwPE
         OylZ6Le9a3SQY+bJ9QJPBsgFsFWWoYrM40PJOIQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Schspa Shi <schspa@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 4.19 060/234] random: fix typo in comments
Date:   Thu, 23 Jun 2022 18:42:07 +0200
Message-Id: <20220623164344.762097921@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623164343.042598055@linuxfoundation.org>
References: <20220623164343.042598055@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Schspa Shi <schspa@gmail.com>

commit c0a8a61e7abbf66729687ee63659ee25983fbb1e upstream.

s/or/for

Signed-off-by: Schspa Shi <schspa@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/random.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -101,7 +101,7 @@
  * ===============================
  *
  * There are four exported interfaces; two for use within the kernel,
- * and two or use from userspace.
+ * and two for use from userspace.
  *
  * Exported interfaces ---- userspace output
  * -----------------------------------------


