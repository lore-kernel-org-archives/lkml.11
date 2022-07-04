Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A446CCA482
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Jul 2022 11:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbiGDLgM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Jul 2022 07:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiGDLgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:36:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F75711448
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:36:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lc3f73t78z4xLX;
        Mon,  4 Jul 2022 21:35:59 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <9f05937d8722ddd2064a7c2362d8f9000e15e1ba.1652863723.git.christophe.leroy@csgroup.eu>
References: <9f05937d8722ddd2064a7c2362d8f9000e15e1ba.1652863723.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/irq: remove inline assembly in hard_irq_disable macro
Message-Id: <165693439618.9954.17884981112281314426.b4-ty@ellerman.id.au>
Date:   Mon, 04 Jul 2022 21:33:16 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 10:48:55 +0200, Christophe Leroy wrote:
> Use WRITE_ONCE() instead of opencoding the saving of current
> stack pointeur.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/irq: remove inline assembly in hard_irq_disable macro
      https://git.kernel.org/powerpc/c/077fc62b2b66a95af43dbb363fb8e932999812d3

cheers
