Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33050C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Apr 2022 13:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbiDINnw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Apr 2022 09:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiDINnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:43:49 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223461EED2;
        Sat,  9 Apr 2022 06:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649511698;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=YaMlPLCKILQ1VdogLAQ5MLRNSt8DudVB6MVrn7CZCaY=;
    b=QBm8jET4ZrxNUlGfwaje5pbnOyDuqoiHUDzMlmeFGvMWDuJkK9Fa3lY93CExRQexUa
    pvZOgFBpK/YZoJ9NTvJpyDigADoK3NU6CKmgXIpdEyB6kj+NRHvsN1Trr0RHnHR5zbOk
    gLIBU85gdkL5QNVHe6EUI1w0Oauwo1Ggwy8Ky+YDHh6XJGxgPrcrMjWtzc9niJW9T+pD
    Qwte1vegJp/kdqetEWFVQ60w8T3JM2FGjd8PyxmTcpjuhaeqizndU3zkihRHWLunWL1u
    dyBnqJHXzykzkJ25JdPKh/NHuhtkB+pHb4pLfLCT0Ovsh9yz9eqrqdC9jWZEgp3L3ODk
    fB4A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39DfbuXb
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:41:37 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 05/18] MIPS: DTS: jz4780: fix pinctrl as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <f40e1a00-be4d-11c7-6a7c-6b50635a2960@linaro.org>
Date:   Sat, 9 Apr 2022 15:41:37 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <499848FD-3F64-4B5D-9259-5C9E1ED4E8AB@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <1941bc4ed553b27f399ad00ea61ff2b0237d14e3.1649443080.git.hns@goldelico.com>
 <e905896e-335d-a88a-1961-d17b92e46585@linaro.org>
 <530E0F7F-FC03-45DD-BF87-D049D3108AD3@goldelico.com>
 <c84b5ec0-0193-ab62-1985-25bc2baa9f05@linaro.org>
 <B5EB5983-DA9F-4631-B737-2B1417CF9054@goldelico.com>
 <f40e1a00-be4d-11c7-6a7c-6b50635a2960@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 09.04.2022 um 15:24 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 09/04/2022 15:22, H. Nikolaus Schaller wrote:
>>>=20
>>> What does that mean? One cannot create multiple patches and apply =
them?
>>=20
>> This patch set was created by some automatic scripts. And they =
produce one patch
>> per group of warnings.
>>=20
>> But here you ask me to merge 4 unrelated topics into a single one.
>>=20
>> Or do you mean something else?
>=20
> You can edit a commit, right? git commit --amend? So where is the =
problem?

It is not about capabilites...

It is about understanding why you want it and what you expect.

>=20
>>=20
>>>=20
>>>> And they are not related. Every one is based on a different .yaml
>>>> schema file.
>>>=20
>>> Which does not matter, because the name of the node does not matter. =
We
>>> enforce it in schema to makes things organized and easier in =
testing.
>>> This does not fix any real problem, just the problem we created by
>>> ourselves with schema.
>>>=20
>>>>=20
>>>> That in all cases the result looks similar comes from similar
>>>> requirements by the schemata and has no inherent connection.
>>>=20
>>> All schemas will require it, won't they? The same for arm...
>>=20
>> We may be talking about different things here.
>>=20
>> My understanding:
>> you ask me to merge 5/18, 8/18, 9/18, 12/18 because they contain =
"controller" in the node-name.
>>=20
>> Right? If not then we must clarify that first.
>=20
> No. I ask you to fix all pin-controller cases, for entire MIPS, not =
just
> one.

Oops. Nope. I am a volunteer and neither your employee nor slave.

> And in one month one more. And then again one more.

No. I work for the topics I choose to work on and share the results.
Open source lives from taking and giving...

If you want me to contribute, please be not demanding.

BR and thanks,
Nikolaus=
