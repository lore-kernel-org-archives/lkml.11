Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D46C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351707AbiBUJui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:50:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351461AbiBUJp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:45:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4553F889;
        Mon, 21 Feb 2022 01:18:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6DEA9CE0E76;
        Mon, 21 Feb 2022 09:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590A6C340E9;
        Mon, 21 Feb 2022 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645435102;
        bh=E7FOSdbTRTgamGUuWjaPs4cyaZmb3dvKjzdHiR8bK6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j7GCHcvbU1S241NytxAuH+kfz2nSkayzYpW/v73rWmtgUmm3wooNMuTOGTATLKHPQ
         74n9weEa6naK2p5MtkIBOuWk5Hu1/eD7XojI34Rr6asiEKzi1MShswohgw8G/a1saE
         NKjxvURparNqiwqBwlswM6nQOmu7nPttMO8nP02E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 5.16 013/227] parisc: Show error if wrong 32/64-bit compiler is being used
Date:   Mon, 21 Feb 2022 09:47:12 +0100
Message-Id: <20220221084935.279675188@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084934.836145070@linuxfoundation.org>
References: <20220221084934.836145070@linuxfoundation.org>
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


