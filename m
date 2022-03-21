Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19853C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 15:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349906AbiCUPSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiCUPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:18:28 -0400
X-Greylist: delayed 2095 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Mar 2022 08:17:02 PDT
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C73105064;
        Mon, 21 Mar 2022 08:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zPMe5slwjVlR5NZ8SoEn7+jv/tU4wKHM4MULXO4el7E=; b=lP9VSHa8/RitwBvhw1IRLZWY1s
        ntwJSXFtmAUK5Wy+pERCG/tr7Tj7+wIMr7/QSpTYj2QHXsM0UUHKhm9NKq94LFVwWEZVPhmqiuxjE
        I3bembYQkjV3McKUcJ18LmCUlyC669SRGC8HssNm6AAhaOg3DqtG4q12QQTp5uQRcljDmd5sgM3/z
        Io4axnOpi8u5Q9R1Bb78+4EyJA7mpdsj8MzGzuOEDjwf/gX9CfUqzjaNa5kurNld/Asq8hLLUjkNe
        3OeKjY1p8fIdrXOdOhRI+Zwdx3xEZz0gR9yB/4zCdE3MW0R/z+xC+w+wDBQ7CM8/WyjzjT0xMKRXp
        dxN5vsNA==;
Received: from [187.39.124.208] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nWJEP-0002GL-Uz; Mon, 21 Mar 2022 15:42:02 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org, gpiccoli@igalia.com,
        kernel@gpiccoli.net, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] Documentation: Fix duplicate statement about raw_spinlock_t type
Date:   Mon, 21 Mar 2022 11:41:33 -0300
Message-Id: <20220321144133.49804-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unless it was duplicate on purpose, to emphasize that a raw_spinlock_t
is always a spinning lock regardless of PREEMPT_RT or kernel config,
it's a bit odd that this text is duplicate. So, this patch just clean
it up, keeping the consistency with the other sections of the text.

Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 919e9e6395cf ("Documentation: Add lock ordering and nesting documentation")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 Documentation/locking/locktypes.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
index bfa75ea1b66a..9933faad4771 100644
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -211,9 +211,6 @@ raw_spinlock_t and spinlock_t
 raw_spinlock_t
 --------------
 
-raw_spinlock_t is a strict spinning lock implementation regardless of the
-kernel configuration including PREEMPT_RT enabled kernels.
-
 raw_spinlock_t is a strict spinning lock implementation in all kernels,
 including PREEMPT_RT kernels.  Use raw_spinlock_t only in real critical
 core code, low-level interrupt handling and places where disabling
-- 
2.35.1

