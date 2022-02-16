Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2074FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 12:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiBPMaa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 07:30:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiBPMa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:30:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BE62A4147
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:30:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzHNN2gNGz4xn1;
        Wed, 16 Feb 2022 23:30:12 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <b04c246874b716911139c04bc004b3b14eed07ef.1641817763.git.christophe.leroy@csgroup.eu>
References: <b04c246874b716911139c04bc004b3b14eed07ef.1641817763.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/bpf: Always reallocate BPF_REG_5, BPF_REG_AX and TMP_REG when possible
Message-Id: <164501434813.521186.4786277291117198839.b4-ty@ellerman.id.au>
Date:   Wed, 16 Feb 2022 23:25:48 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 12:29:42 +0000, Christophe Leroy wrote:
> BPF_REG_5, BPF_REG_AX and TMP_REG are mapped on non volatile registers
> because there are not enough volatile registers, but they don't need
> to be preserved on function calls.
> 
> So when some volatile registers become available, those registers can
> always be reallocated regardless of whether SEEN_FUNC is set or not.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/bpf: Always reallocate BPF_REG_5, BPF_REG_AX and TMP_REG when possible
      https://git.kernel.org/powerpc/c/a8936569a07bf27cc9cfc2a39a1e5ea91273b2d4

cheers
