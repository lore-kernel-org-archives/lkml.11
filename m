Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9540FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 02:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiBRCKd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 21:10:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiBRCKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:10:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C0210DC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 18:10:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K0FX33bvXz4xcd;
        Fri, 18 Feb 2022 13:10:11 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Jason Wang <wangborong@cdjrlc.com>, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, paulus@samba.org
In-Reply-To: <20211220030243.603435-1-wangborong@cdjrlc.com>
References: <20211220030243.603435-1-wangborong@cdjrlc.com>
Subject: Re: [PATCH] powerpc/kvm: no need to initialise statics to 0
Message-Id: <164515018949.908917.14452521807329931842.b4-ty@ellerman.id.au>
Date:   Fri, 18 Feb 2022 13:09:49 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 11:02:43 +0800, Jason Wang wrote:
> Static variables do not need to be initialised to 0, because compiler
> will initialise all uninitialised statics to 0. Thus, remove the
> unneeded initialization.
> 
> 

Applied to powerpc/topic/ppc-kvm.

[1/1] powerpc/kvm: no need to initialise statics to 0
      https://git.kernel.org/powerpc/c/8e0f353a44ff3d65d933b8c0e4fb15dc89d46617

cheers
