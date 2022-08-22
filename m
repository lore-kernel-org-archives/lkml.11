Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3A8C28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 13:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiHVNLy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 09:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiHVNLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:11:52 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F13B140F1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:11:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661173908; bh=HTMe+NWdQhVrv4pk9fiHKxQBTpwr9lj6IAS27IV/VvE=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=q8L1pggjM0PWgIqJYCIL22femgo3CMmkx0sHKqqiWpKLGyDateOmHoMO2m3Jdpns4
         pzMV1WmAXjXHC9xY7YeZueMmQYvpvJnomm4uMbPMJ1LJoTNpz49IJjCzAK99y2lC5u
         xad/jYkJEXvQ9UBtmtWFntivWc3hmV2UGB+mIGi4=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] ASoC: dapm: Export new 'graph.dot' file in debugfs
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <YwN+0yHSOSC2aD+J@sirena.org.uk>
Date:   Mon, 22 Aug 2022 15:11:48 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6EDC1D4B-4B84-49A2-A60A-EA15D27251A7@cutebit.org>
References: <20220822095242.3779-1-povik+lin@cutebit.org>
 <YwN2Pd4Ez08yDFno@sirena.org.uk>
 <3234D74E-0DFF-4BB5-87ED-6135BAC1F31D@cutebit.org>
 <YwN+0yHSOSC2aD+J@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 22. 8. 2022, at 15:04, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Mon, Aug 22, 2022 at 02:38:09PM +0200, Martin Povi=C5=A1er wrote:
>>> On 22. 8. 2022, at 14:27, Mark Brown <broonie@kernel.org> wrote:
>=20
>>> There was a tool floating about in the past (last copy I knew about =
was
>>> on Wolfson's git but they took that down) - can we not just continue =
to
>>> do that?
>=20
>> I don=E2=80=99t know the tool or where would I find it. I think =
it=E2=80=99s neat
>=20
> Copying in Charles and Richard who might know about the status of the
> tool Dimitris wrote.

Thanks.

>> simply having a =E2=80=98graph.dot=E2=80=99 at hand, especially since =
it requires
>> little code. (Although sure there=E2=80=99s the danger of it =
growing.)
>=20
> I'm also worried about people going in and wanting other more tool
> specific formats adding, if we didn't have anything at all it'd be one
> thing but we do have something.

Sure, although I would argue DOT is by a large margin the standard
format to represent graphs in.

Best,
Martin

