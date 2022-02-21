Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB543C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349954AbiBUJ37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:29:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348475AbiBUJUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:20:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F5A340EF;
        Mon, 21 Feb 2022 01:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27273612B1;
        Mon, 21 Feb 2022 09:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6B4C340F3;
        Mon, 21 Feb 2022 09:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645434457;
        bh=E7FOSdbTRTgamGUuWjaPs4cyaZmb3dvKjzdHiR8bK6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0OaHbfasLcVUJubLWyhVPRDVyuTUkg/37E3g38JvRY8dLfSjGCta5RbWiMeKyTiB
         kLesrsl7+VZzEXusO9DmOMhxJ3/XxUL1MUVhoYRhzENsGCUhJUMyrEXPhgAOq+msAD
         E679EF8Em49FUNGTVX5UiZ3eK/oAjko0I+xp+z+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 5.15 007/196] parisc: Show error if wrong 32/64-bit compiler is being used
Date:   Mon, 21 Feb 2022 09:47:19 +0100
Message-Id: <20220221084931.134577744@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084930.872957717@linuxfoundation.org>
References: <20220221084930.872957717@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit b160628e9ebcdc85d0db9d7f423c26b3c7c179d0 upstream.

It happens quite often that people use the wrong compiler to build the
kernel:

make ARCH=parisc   -> builds the 32-bit kernel
make ARCH=parisc64 -> builds the 64-bit kernel

This patch adds a sanity check which errors out with an instruction how
use the correct ARCH= option.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/asm/bitops.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/parisc/include/asm/bitops.h
+++ b/arch/parisc/include/asm/bitops.h
@@ -12,6 +12,14 @@
 #include <asm/barrier.h>
 #include <linux/atomic.h>
 
+/* compiler build environment sanity checks: */
+#if !defined(CONFIG_64BIT) && defined(__LP64__)
+#error "Please use 'ARCH=parisc' to build the 32-bit kernel."
+#endif
+#if defined(CONFIG_64BIT) && !defined(__LP64__)
+#error "Please use 'ARCH=parisc64' to build the 64-bit kernel."
+#endif
+
 /* See http://marc.theaimsgroup.com/?t=108826637900003 for discussion
  * on use of volatile and __*_bit() (set/clear/change):
  *	*_bit() want use of volatile.


