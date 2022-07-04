Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A58EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Jul 2022 11:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiGDLga (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Jul 2022 07:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiGDLgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:36:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E957D1145A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:36:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lc3fG1kp7z4xZp;
        Mon,  4 Jul 2022 21:36:06 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <11956ec181a034b51a881ac9c059eea72c679a73.1651828453.git.christophe.leroy@csgroup.eu>
References: <11956ec181a034b51a881ac9c059eea72c679a73.1651828453.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/2] powerpc: Include asm/firmware.h in all users of firmware_has_feature()
Message-Id: <165693438809.9954.10973271301245396597.b4-ty@ellerman.id.au>
Date:   Mon, 04 Jul 2022 21:33:08 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2022 11:14:24 +0200, Christophe Leroy wrote:
> Trying to remove asm/ppc_asm.h from all places that don't need it
> leads to several failures linked to firmware_has_feature().
> 
> To fix it, include asm/firmware.h in all files using
> firmware_has_feature()
> 
> All users found with:
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc: Include asm/firmware.h in all users of firmware_has_feature()
      https://git.kernel.org/powerpc/c/46d60bdb1283bb0f22d9480e2d6c972623cb4182
[2/2] powerpc: Don't include asm/ppc_asm.h in other headers
      https://git.kernel.org/powerpc/c/e93dee186fc95f2058b0c9d2317d8b876b8512db

cheers
