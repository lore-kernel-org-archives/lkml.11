Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4449DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 10:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiEXKyH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 06:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbiEXKyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:54:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315FB4ECD6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:54:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6rfb6pcwz4ySl;
        Tue, 24 May 2022 20:53:59 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
        Bo Liu <liubo03@inspur.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220401065252.36472-1-liubo03@inspur.com>
References: <20220401065252.36472-1-liubo03@inspur.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: fix the return value of kvm_age_rmapp()
Message-Id: <165338950884.1711920.1652922231071058504.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 20:51:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2022 02:52:52 -0400, Bo Liu wrote:
> The return value type defined in the function kvm_age_rmapp() is
> "bool", but the return value type defined in the implementation of the
> function kvm_age_rmapp() is "int".
> 
> Change the return value type to "bool".
> 
> 
> [...]

Applied to powerpc/topic/ppc-kvm.

[1/1] KVM: PPC: Book3S HV: fix the return value of kvm_age_rmapp()
      https://git.kernel.org/powerpc/c/15eb1b6afc3c73bcd44b5d265d43db666950b5af

cheers
