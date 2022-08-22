Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFFEC28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 12:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiHVMiU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 08:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiHVMiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:38:17 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559E212C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:38:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661171890; bh=wS7eBcU6IrGgczgQRn/ar+Ts2JGTgJKTlU4UR4ZP25U=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=bzkKcz9aP0I6aeaU5C1aSTqv5/6IwA5HePKFdPxuaNr0X09HB12RFYLdDjGvKHbLI
         Im5zOhghXB6T4gVQMpk+IpcIBkcOQTaJdnbfoKRWr+Gn6nCWvq1N3gcxnRiAzVOJtG
         zVmVJXE0fP6qDFTxoOVix9nG9fk7IOsRP9q5DzsE=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] ASoC: dapm: Export new 'graph.dot' file in debugfs
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <YwN2Pd4Ez08yDFno@sirena.org.uk>
Date:   Mon, 22 Aug 2022 14:38:09 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3234D74E-0DFF-4BB5-87ED-6135BAC1F31D@cutebit.org>
References: <20220822095242.3779-1-povik+lin@cutebit.org>
 <YwN2Pd4Ez08yDFno@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 22. 8. 2022, at 14:27, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Mon, Aug 22, 2022 at 11:52:42AM +0200, Martin Povi=C5=A1er wrote:
>=20
>> Provide a DOT summary of the DAPM graph in a newly added 'graph.dot'
>> file in debugfs, placed in the card's DAPM directory.
>=20
> There was a tool floating about in the past (last copy I knew about =
was
> on Wolfson's git but they took that down) - can we not just continue =
to
> do that?

I don=E2=80=99t know the tool or where would I find it. I think it=E2=80=99=
s neat
simply having a =E2=80=98graph.dot=E2=80=99 at hand, especially since it =
requires
little code. (Although sure there=E2=80=99s the danger of it growing.)

Martin

