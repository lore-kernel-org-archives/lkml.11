Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAD0C38145
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 11:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiIBLdH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 07:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbiIBLcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:32:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0856437
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 04:31:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MJwhz5DdGz4wgr;
        Fri,  2 Sep 2022 21:31:15 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, Zhouyi Zhou <zhouzhouyi@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <a8298991b3df049a54ee8e558838e34265812014.1661272586.git.christophe.leroy@csgroup.eu>
References: <a8298991b3df049a54ee8e558838e34265812014.1661272586.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Fix hard_irq_disable() with sanitizer
Message-Id: <166211825114.554590.4796763378822550345.b4-ty@ellerman.id.au>
Date:   Fri, 02 Sep 2022 21:30:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 18:36:35 +0200, Christophe Leroy wrote:
> As reported by Zhouyi Zhou, WRITE_ONCE() is not atomic
> as expected when KASAN or KCSAN are compiled in.
> 
> Fix it by re-implementing it using inline assembly.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc: Fix hard_irq_disable() with sanitizer
      https://git.kernel.org/powerpc/c/814816d71e29934d0a76ee259b54c0b80c3b0e4a

cheers
