Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54496C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 04:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346227AbiCKE1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 23:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiCKE1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:27:49 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CE31A41C0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:26:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFCYv1GnHz4xcC;
        Fri, 11 Mar 2022 15:26:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1646972804;
        bh=kj3Y9rFdntioquAOckINO/fYRpiknqyh9JlE9pvUSLI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Vqdg28P7wEvdR0OsQnFjMnSgKWofZcoNHyHbXt0cZ7SR6tnO/hQW7oW3YF+ec5eGT
         zca6xSirV7Bo549tLPW6tvMtbO92cD5kBEmrhUCeeVRCJ0UWJdkrbE1x2pMd1GdAn5
         dlrGwS53BaUpvKIm7RMCAFWPU7XGk/66iIo899FRq685I2uDHEs8DDDKqOgsR23l2l
         OrO8lkePGsmUXZcNq7KvouVFnn5Iunaa8q5+RNlY953xnFe2X1CmhDeOjlgNMs5pry
         71qVg1KcR0r5Z9kuGD/cDNSdkPM3glbDcZWYiBujM8HfGC3P7uUFTb4sttCuFu75HE
         tb9mg13cRZH+A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 00/14] Convert powerpc to default topdown mmap layout
 (v8)
In-Reply-To: <ddfed61b-e387-4554-eb88-6654b391d1a4@csgroup.eu>
References: <cover.1646847561.git.christophe.leroy@csgroup.eu>
 <ddfed61b-e387-4554-eb88-6654b391d1a4@csgroup.eu>
Date:   Fri, 11 Mar 2022 15:26:42 +1100
Message-ID: <877d91m7wd.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Hi Michael, hi Andrew
>
> Le 09/03/2022 =C3=A0 18:44, Christophe Leroy a =C3=A9crit=C2=A0:
>> Rebased on top of powerpc/next branch
>>=20
>> This series converts powerpc to default topdown mmap layout.
>>=20
>> powerpc requires its own arch_get_unmapped_area() only when
>> slices are needed, which is only for book3s/64. First part of
>> the series moves slices into book3s/64 specific directories
>> and cleans up other subarchitectures.
>>=20
>> Last part converts to default topdown mmap layout.
>>=20
>> A small modification is done to core mm to allow
>> powerpc to still provide its own arch_randomize_brk()
>>=20
>> Another modification is done to core mm to allow powerpc
>> to use generic versions of get_unmapped_area functions for Radix
>> while still providing its own implementation for Hash, the
>> selection between Radix and Hash being doing at runtime.
>>=20
>> Last modification to core mm is to give len and flags to
>> arch_get_mmap_end().
>>=20
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>
> What's the way forward for this series ?

It's a bit of a tricky series.

> Patches 1 has been merged in PCI tree.

That's fine I guess, it can go into v5.18, it's only patch 14 that
depends on it.

> Patches 2 to 5 are core mm, patch 5 being a fix.

A fix for arm64 even, just to complicate things :)

> Then patches 6 to 14 are powerpc.

With a fairly sizable diffstat, ie. likely to conflict.

> What will be the merge strategy ? I guess it's a bit late to get it=20
> through powerpc tree, so I was just wondering whether we could get=20
> patches 2 to 5 in mm this cycle, and the powerpc ones next cycle ?

Yeah I didn't pick it up because the mm changes don't have many acks and
I'm always nervous about carrying generic mm changes.

It would be my preference if Andrew could take 2-5 through mm for v5.18,
but it is quite late, so I'm not sure how he will feel about that.

Arguably 2, 3, 4 do very little. It's only patch 5 that has much effect,
and it has a reviewed-by from Catalin at least.

cheers
