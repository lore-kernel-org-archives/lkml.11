Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A64EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 11:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiEXLP6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 07:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbiEXLPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:15:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A8B6FA0D;
        Tue, 24 May 2022 04:15:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7T2rBQz4ySV;
        Tue, 24 May 2022 21:15:33 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     devicetree@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Scott Wood <oss@buserror.net>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <9949813a6b758903b7bee910f798ba2ca82ff8ee.1648720908.git.christophe.leroy@csgroup.eu>
References: <9949813a6b758903b7bee910f798ba2ca82ff8ee.1648720908.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/85xx: Remove FSL_85XX_CACHE_SRAM
Message-Id: <165339057880.1718562.6883347220711607278.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 12:03:06 +0200, Christophe Leroy wrote:
> CONFIG_FSL_85XX_CACHE_SRAM is an option that is not
> user selectable and which is not selected by any driver
> nor any defconfig.
> 
> Remove it and all associated code.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/85xx: Remove FSL_85XX_CACHE_SRAM
      https://git.kernel.org/powerpc/c/dc21ed2aef4150fc2fcf58227a4ff24502015c03

cheers
