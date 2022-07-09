Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E2BC433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Jul 2022 10:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiGIKSO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Jul 2022 06:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGIKSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:18:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A543ED65
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 03:18:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lg5h245XKz4xXD;
        Sat,  9 Jul 2022 20:18:10 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        mpe@ellerman.id.au,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        paulus@samba.org
Cc:     Juerg Haefliger <juergh@canonical.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220520115431.147593-1-juergh@canonical.com>
References: <20220520115431.147593-1-juergh@canonical.com>
Subject: Re: [PATCH] KVM: PPC: Kconfig: Fix indentation
Message-Id: <165736167288.12236.9958189155534556825.b4-ty@ellerman.id.au>
Date:   Sat, 09 Jul 2022 20:14:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 13:54:31 +0200, Juerg Haefliger wrote:
> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that
> violate these rules.
> 
> 

Applied to powerpc/topic/ppc-kvm.

[1/1] KVM: PPC: Kconfig: Fix indentation
      https://git.kernel.org/powerpc/c/81e9685dd41384a39adda823df8b4f6e16ec2898

cheers
