Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BC3C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 10:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiCLKcN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 05:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiCLKcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:32:01 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A8F23D1BC
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:30:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFzbf0s1pz4xsg;
        Sat, 12 Mar 2022 21:30:54 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org, benh@kernel.crashing.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, jk@ozlabs.org,
        YueHaibing <yuehaibing@huawei.com>, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220308100928.23540-1-yuehaibing@huawei.com>
References: <20220308100928.23540-1-yuehaibing@huawei.com>
Subject: Re: [PATCH v2 -next] powerpc/spufs: Fix build warning when CONFIG_PROC_FS=n
Message-Id: <164708098605.827774.15948027933865085338.b4-ty@ellerman.id.au>
Date:   Sat, 12 Mar 2022 21:29:46 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 18:09:28 +0800, YueHaibing wrote:
> arch/powerpc/platforms/cell/spufs/sched.c:1055:12: warning: ‘show_spu_loadavg’ defined but not used [-Wunused-function]
>  static int show_spu_loadavg(struct seq_file *s, void *private)
>             ^~~~~~~~~~~~~~~~
> 
> Move it into #ifdef block to fix this, also remove unneeded semicolon.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/spufs: Fix build warning when CONFIG_PROC_FS=n
      https://git.kernel.org/powerpc/c/5986f6b6575ac830ede9648cfb64353c58067a9f

cheers
