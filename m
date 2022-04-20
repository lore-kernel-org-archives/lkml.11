Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EF6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 13:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378671AbiDTNog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 09:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378648AbiDTNoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:44:32 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9E83ED11;
        Wed, 20 Apr 2022 06:41:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1650462099; bh=sZf5aeyOv/geE7PqxpKGqbaO7oijs/p3MQFNG21fcgU=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=OosE2T6qOYxApS8+K6WqIAXECA0TUX553O0iGihCN/FhGYcSMPkz8TuH0qbFi2evB
         /lp1fg8aGNlRcgCqfnoNR+DPffFAzmDKT7wRek1YYcF/H37rjWQNR+BRmsFfWbkk2d
         d8JYBlu8qFD7pnIec5uqaZEAD/e/0xgx/myztccA=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2 2/2] dmaengine: apple-admac: Add Apple ADMAC driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <Yl//MF1MeUFE6N4y@matsya>
Date:   Wed, 20 Apr 2022 15:41:37 +0200
Cc:     =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <69599B8F-8F88-42BC-B159-863D1F9E729A@cutebit.org>
References: <20220411222204.96860-1-povik+lin@cutebit.org>
 <20220411222204.96860-3-povik+lin@cutebit.org> <Yl//MF1MeUFE6N4y@matsya>
To:     Vinod Koul <vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 20. 4. 2022, at 14:40, Vinod Koul <vkoul@kernel.org> wrote:
>=20
> On 12-04-22, 00:22, Martin Povi=C5=A1er wrote:
>=20
>> +struct admac_chan {
>> +	int no;
>=20
> Unsigned int perhaps?

Sure.

>=20
>> +static int admac_desc_free(struct dma_async_tx_descriptor *tx)
>> +{
>> +	struct admac_tx *adtx =3D to_admac_tx(tx);
>> +
>> +	devm_kfree(to_admac_chan(tx->chan)->host->dev, adtx);
>=20
> Why use devm for descriptor memory?

Well, good point. :-)

>> +static int admac_device_config(struct dma_chan *chan,
>> +			       struct dma_slave_config *config)
>> +{
>> +	struct admac_chan *adchan =3D to_admac_chan(chan);
>> +	struct admac_data *ad =3D adchan->host;
>> +	bool is_tx =3D admac_chan_direction(adchan->no) =3D=3D =
DMA_MEM_TO_DEV;
>=20
> so are the channel directions hard wired in hardware?

Yes they are.

> --=20
> ~Vinod

Martin

