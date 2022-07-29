Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44396C00144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 13:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbiG2NLf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 09:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbiG2NKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:10:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141F73B961
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:10:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSYy1NBZz4xFy;
        Fri, 29 Jul 2022 23:10:46 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <b2d762191b095530789ac8b71b167c6740bb6aed.1657205708.git.christophe.leroy@csgroup.eu>
References: <b2d762191b095530789ac8b71b167c6740bb6aed.1657205708.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] powerpc/probes: Remove ppc_opcode_t
Message-Id: <165909975955.253830.3692391557565882739.b4-ty@ellerman.id.au>
Date:   Fri, 29 Jul 2022 23:02:39 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2022 16:55:14 +0200, Christophe Leroy wrote:
> ppc_opcode_t is just an u32. There is no point in hiding u32
> behind such a typedef. Remove it.
> 
> 

Applied to powerpc/next.

[1/3] powerpc/probes: Remove ppc_opcode_t
      https://git.kernel.org/powerpc/c/7b48377e1d9f68a1b58dfd22d40b083f38ce76a0
[2/3] powerpc/ppc-opcode: Define and use PPC_RAW_TRAP() and PPC_RAW_TW()
      https://git.kernel.org/powerpc/c/d00d762daf1278641eec92d74011a7e625e84a68
[3/3] powerpc/ppc-opcode: Define and use PPC_RAW_SETB()
      https://git.kernel.org/powerpc/c/de40303b54bc458d7df0d4b4ee1d296df7fe98c7

cheers
