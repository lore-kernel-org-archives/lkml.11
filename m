Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 12:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345118AbiDDMd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 08:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242129AbiDDMd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:33:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44A32529A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:31:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KX9B809kHz4xLT;
        Mon,  4 Apr 2022 22:31:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1649075488;
        bh=hG6TZKEJZxMsTA02FMCiW8eZLr8jMlFUkObaIFUyTbI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=L8UxTIfRsNHbVWg4V6jVyub1n8Ldvb7dX6QfXFLdjJhDGEOw25R9QtIaRWIJX5iC7
         lnxvvLG2KzWhM/JpGHUE9LIjgtO3mD1Am9nIDlWIeF8CS8VpA+PBQDJo+uITDuG9AW
         ZpgS6vBov1FuXD/DvHOx7Qdgs5eWt8gz3lU9LMRWITkcjHhEKlkpPJrNE0ne2qBJoa
         2UPJm3fnhPbJtaqJxVJWPUQ4FG/zlQM2Vu1Rc8r1zBI16GRnyYtLU0fQjncEV16FOk
         uFvNLnERwz2N0NkmgdBbc1NS3W0ruURAqYr/ZzOE8Z8gzQ0fmYP/kz/2DkoEfmyLMA
         9WBkKCOkcTDUw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "songyuanzheng@huawei.com" <songyuanzheng@huawei.com>
Subject: Re: [PATCH v4 1/2] Revert "powerpc: Set max_mapnr correctly"
In-Reply-To: <0c6e13cc-f768-2cb4-0aa3-cd090b99fc8f@huawei.com>
References: <20220216121109.157605-1-wangkefeng.wang@huawei.com>
 <b2ff771c-01ef-3f14-f22d-9248735fdc77@huawei.com>
 <de3e12e2-6dff-90cd-3f47-fe8deaae1fa8@csgroup.eu>
 <0c6e13cc-f768-2cb4-0aa3-cd090b99fc8f@huawei.com>
Date:   Mon, 04 Apr 2022 22:31:27 +1000
Message-ID: <877d8581y8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kefeng Wang <wangkefeng.wang@huawei.com> writes:
> On 2022/3/28 22:12, Christophe Leroy wrote:
>> Hi,
>>
>> Le 26/03/2022 =C3=A0 08:55, Kefeng Wang a =C3=A9crit=C2=A0:
>>> Hi maintainers=EF=BC=8C
>>>
>>> I saw the patches has been reviewed[1], could they be merged?
>> Thinking about it once more, I think the patches should go in reverse
>> order. Patch 2 should go first and patch 1 should go after.
>>
>> Otherwise, once patch 1 is applied and patch 2 is not applied yet,
>> virt_addr_valid() doesn't work anymore.
>
> Should I resend them or could the maintainer reverse order when merging=20
> them?

I'll reverse them. I've found some breakage in other code while testing
this, so I'll fix that up first before merging these.

In patch 2 you didn't say what hardware you hit this on, what CPU does
your system have?

cheers
