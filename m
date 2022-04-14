Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC8AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 17:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbiDNR3g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbiDNR3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:29:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A690C9B4E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:27:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD37BB8217B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFD2C385A5;
        Thu, 14 Apr 2022 17:26:59 +0000 (UTC)
Date:   Thu, 14 Apr 2022 18:26:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kmemleak: take a full lowmem check in
 kmemleak_*_phys()
Message-ID: <YlhZYMa8Pur6203W@arm.com>
References: <20220413122925.33856-1-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413122925.33856-1-patrick.wang.shcn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:29:25PM +0800, Patrick Wang wrote:
> The kmemleak_*_phys() apis do not check the address for lowmem's min
> boundary, while the caller may pass an address below lowmem, which
> will trigger an oops:
> 
> # echo scan > /sys/kernel/debug/kmemleak
> [   54.888353] Unable to handle kernel paging request at virtual address ff5fffffffe00000
> [   54.888932] Oops [#1]
> [   54.889102] Modules linked in:
> [   54.889326] CPU: 2 PID: 134 Comm: bash Not tainted 5.18.0-rc1-next-20220407 #33
> [   54.889620] Hardware name: riscv-virtio,qemu (DT)
> [   54.889901] epc : scan_block+0x74/0x15c
> [   54.890215]  ra : scan_block+0x72/0x15c
> [   54.890390] epc : ffffffff801e5806 ra : ffffffff801e5804 sp : ff200000104abc30
> [   54.890607]  gp : ffffffff815cd4e8 tp : ff60000004cfa340 t0 : 0000000000000200
> [   54.890835]  t1 : 00aaaaaac23954cc t2 : 00000000000003ff s0 : ff200000104abc90
> [   54.891024]  s1 : ffffffff81b0ff28 a0 : 0000000000000000 a1 : ff5fffffffe01000
> [   54.891201]  a2 : ffffffff81b0ff28 a3 : 0000000000000002 a4 : 0000000000000001
> [   54.891377]  a5 : 0000000000000000 a6 : ff200000104abd7c a7 : 0000000000000005
> [   54.891552]  s2 : ff5fffffffe00ff9 s3 : ffffffff815cd998 s4 : ffffffff815d0e90
> [   54.891727]  s5 : ffffffff81b0ff28 s6 : 0000000000000020 s7 : ffffffff815d0eb0
> [   54.891903]  s8 : ffffffffffffffff s9 : ff5fffffffe00000 s10: ff5fffffffe01000
> [   54.892078]  s11: 0000000000000022 t3 : 00ffffffaa17db4c t4 : 000000000000000f
> [   54.892271]  t5 : 0000000000000001 t6 : 0000000000000000
> [   54.892408] status: 0000000000000100 badaddr: ff5fffffffe00000 cause: 000000000000000d
> [   54.892643] [<ffffffff801e5a1c>] scan_gray_list+0x12e/0x1a6
> [   54.892824] [<ffffffff801e5d3e>] kmemleak_scan+0x2aa/0x57e
> [   54.892961] [<ffffffff801e633c>] kmemleak_write+0x32a/0x40c
> [   54.893096] [<ffffffff803915ac>] full_proxy_write+0x56/0x82
> [   54.893235] [<ffffffff801ef456>] vfs_write+0xa6/0x2a6
> [   54.893362] [<ffffffff801ef880>] ksys_write+0x6c/0xe2
> [   54.893487] [<ffffffff801ef918>] sys_write+0x22/0x2a
> [   54.893609] [<ffffffff8000397c>] ret_from_syscall+0x0/0x2

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
