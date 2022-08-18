Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF63C32772
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 17:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344718AbiHRRyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 13:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbiHRRyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:54:20 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE408688A;
        Thu, 18 Aug 2022 10:54:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1660845251; bh=bQPe7B4ZCavRnagWoIqyzCrbJt6mWXMyQjixEkuQ6Pw=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=a/dSJC3iVkkSKzJdT7hR9v/d2iSqsuWf88EYWvE13FKdozwM/bLdOa6wA/iTod2nv
         u7tjP1v3jHurbWNjso9Pz2J9HNikex5HMSruwf9aqyJr5TisMYl8mo/QBgInduRM40
         A7gIo5oxuEsgxEZ1vhUcs3RsC5e/xbqJl5TDWMqg=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 2/3] ASoC: apple: mca: Start new platform driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <82B580B4-85BF-4ABA-B098-98E3CA9EE247@cutebit.org>
Date:   Thu, 18 Aug 2022 19:54:09 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <414CEE0D-AED4-4900-88BE-A3BD993D79DD@cutebit.org>
References: <20220808224153.3634-1-povik+lin@cutebit.org>
 <20220808224153.3634-3-povik+lin@cutebit.org>
 <53c8f062-a760-c65f-479e-53e7991b3f66@linaro.org>
 <82B580B4-85BF-4ABA-B098-98E3CA9EE247@cutebit.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 9. 8. 2022, at 10:54, Martin Povi=C5=A1er <povik+lin@cutebit.org> =
wrote:
>=20
>=20
>> On 9. 8. 2022, at 10:47, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>>=20
>> On 09/08/2022 01:41, Martin Povi=C5=A1er wrote:

(...)

>>> +
>>> +	mca->rstc =3D devm_reset_control_get_shared(&pdev->dev, NULL);
>>> +	if (IS_ERR(mca->rstc)) {
>>> +		dev_dbg(&pdev->dev, "couldn't obtain reset control: =
%pe\n", mca->rstc);
>>> +		mca->rstc =3D NULL;
>>> +	}
>>=20
>> Similar question.
>=20
> Same as above, there=E2=80=99s supposed to be
>=20
>  resets:
>    maxItems: 1
>=20
> in the schema.

Preparing an iteration of the series, I see there *was* the reset in
the schema. Let me know if there is some issue with it.

Martin

>=20
>> Best regards,
>> Krzysztof
>>=20
>=20
> Martin
>=20

