Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEC8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 11:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbiEXLQi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 07:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbiEXLPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:15:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1769891587
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:15:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7m0kpLz4ySl;
        Tue, 24 May 2022 21:15:48 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Miaoqian Lin <linmq006@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Jin Qing <b24347@freescale.com>,
        Alexandre Bounine <alexandre.bounine@idt.com>,
        Liu Gang <Gang.Liu@freescale.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220512123724.62931-1-linmq006@gmail.com>
References: <20220512123724.62931-1-linmq006@gmail.com>
Subject: Re: [PATCH] powerpc/fsl_rio: Fix refcount leak in fsl_rio_setup
Message-Id: <165339058446.1718562.15673499679733918948.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:44 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 16:37:18 +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/fsl_rio: Fix refcount leak in fsl_rio_setup
      https://git.kernel.org/powerpc/c/fcee96924ba1596ca80a6770b2567ca546f9a482

cheers
