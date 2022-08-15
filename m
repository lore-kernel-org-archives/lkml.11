Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E39C28B2B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 20:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346357AbiHOUO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 16:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346214AbiHOULD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:11:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF7AAE77;
        Mon, 15 Aug 2022 11:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B49F6125B;
        Mon, 15 Aug 2022 18:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223E3C433D6;
        Mon, 15 Aug 2022 18:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660589826;
        bh=7pMGTLfm7+yf402Et0WC41HMCYeZJIfscGaDIL9XAwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YyciSNjTFsVI903KLmbs2BIgr4Ob/GesIhUJtBubxDfUypYJSwgl8FY+NqKFjugRk
         E3qhbQM+/ZGyZBlKicbhZm1oGoW1QJsUWuDBa5KnwWL4/QaE/iYwjfz1/KAcf3AbP3
         s5sqhBm7gLYEHWwEJu47dLC46VsZnKGYSSBEllyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 5.18 0059/1095] parisc: io_pgetevents_time64() needs compat syscall in 32-bit compat mode
Date:   Mon, 15 Aug 2022 19:50:58 +0200
Message-Id: <20220815180431.926297776@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit 6431e92fc827bdd2d28f79150d90415ba9ce0d21 upstream.

For all syscalls in 32-bit compat mode on 64-bit kernels the upper
32-bits of the 64-bit registers are zeroed out, so a negative 32-bit
signed value will show up as positive 64-bit signed value.

This behaviour breaks the io_pgetevents_time64() syscall which expects
signed 64-bit values for the "min_nr" and "nr" parameters.
Fix this by switching to the compat_sys_io_pgetevents_time64() syscall,
which uses "compat_long_t" types for those parameters.

Cc: <stable@vger.kernel.org> # v5.1+
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/syscalls/syscall.tbl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -413,7 +413,7 @@
 412	32	utimensat_time64		sys_utimensat			sys_utimensat
 413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive


