Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B06C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 07:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346982AbiFJHeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 03:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346946AbiFJHdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:33:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88344131F1F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:33:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LKCPY2k9Hz4xZ7;
        Fri, 10 Jun 2022 17:33:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1654846417;
        bh=ZwuNMyeEn4/k09HgbzyRNNQPwPmbjayEkiANCys25H0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XZpuxytflZ9rOzutXEJeY1hrf7cGPBRASffqsC+RY8GkqWOE1YRr35BrNOudZcwVC
         6KS++Uxq/eQjykz/AsvPc3QJ//mam7lfobCTOprGE9zrIObqcBhV6c5KjubpNOF3Px
         g3QMdsMfxMZf+eO2TZbRAvOmsDN0SWhYtFdkI516JFPgRbHs52z2zCL1Otpk7amP/e
         hf8aZh7abJTWfCb8yeA8YWPGyAqeA6KxfNlQ2hLmkNxdIWTcQSVDCQShlJ4D4IfIPS
         mHg1NzqfoDGSAQklujgnHHK84B5snoRpangujWi0B8OqyWqNx/SBAJogXWiS+ZpaT6
         0NuEzFmRt6Ubw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pci: Add config option for using OF 'reg' for
 PCI domain
In-Reply-To: <20220504175718.29011-1-pali@kernel.org>
References: <20220504175718.29011-1-pali@kernel.org>
Date:   Fri, 10 Jun 2022 17:33:32 +1000
Message-ID: <87edzxc6r7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:
> Since commit 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on
> device-tree properties"), powerpc kernel always fallback to PCI domain
> assignment from OF / Device Tree 'reg' property of the PCI controller.
>
> PCI code for other Linux architectures use increasing assignment of the P=
CI
> domain for individual controllers (assign the first free number), like it
> was also for powerpc prior mentioned commit.
>
> Upgrading powerpc kernels from LTS 4.4 version (which does not contain
> mentioned commit) to new LTS versions brings a regression in domain
> assignment.

I'm sorry this broke your system. But I don't really consider it a
regression, the kernel provides no guarantee about the PCI domain
numbering across LTS releases.

Prior to the change the numbering was just based on the order the PHBs
were discovered in the device tree, which is not robust. A cosmetic
refactor of the device tree source could cause PHBs to be discovered in
a different order.

Similarly a change in firmware PCI discovery or device tree generation
could cause the numbering to change.

If you have scripts that are looking for certain devices they can use
the vendor/device fields in sysfs to find the actual devices they want,
not just whatever happens to be at 0000:01:00.0.

> Fix this issue by introducing a new option CONFIG_PPC_PCI_DOMAIN_FROM_OF_=
REG
> When this options is disabled then powerpc kernel would assign PCI domains
> in the similar way like it is doing kernel for other architectures and al=
so
> how it was done prior that commit.

I really don't want a config option for that.

There is a device tree property "linux,pci-domain", described in
Documentation/devicetree/bindings/pci/pci.txt.

Can you try adding that to your device tree and updating
get_phb_number() to look for it?

cheers
