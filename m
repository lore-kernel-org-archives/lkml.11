Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E653C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 02:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiCLCeq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 21:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLCeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:34:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7213E13D562;
        Fri, 11 Mar 2022 18:33:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10502617D4;
        Sat, 12 Mar 2022 02:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A25C340E9;
        Sat, 12 Mar 2022 02:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647052417;
        bh=GGNY0j2NPdsmfEcjre+nJnJmbDsf2XDswNA45NrrSbo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qMZY9aDZVNjBYfYdQ7qMegZ/V7P/eWbBQmTkizELh+Cm4Qrr6y8p/EmFXfgw/n6zA
         B8oLCF7h+wmX+Rky3YZxO8UVep2st1JlUJNhrpPMSpr15Qrr+m98fGxOI/jmvOBKF9
         z6st5RSBVtzPejnovCzbI35KM2mlh5v3qsYv/L6Qswx2i9fPcficIKp7qr+IK2leak
         FSVlyvVrBrb4Fk2aFngYmssxZxOLa3aVQIF8FliZ9/7cKTqlc5WW6eE92y4BPXuPlZ
         x4V12HLYKRGls7j2qzfh/jajIJVck4iQqA4Wc3wQY0tMLsYNaxFWTkjlrCk0yDFcrQ
         QF4XJbrgAkfEg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Yhofs/PbIOmiyNIH@latitude>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net> <20220226010033.6C870C340E7@smtp.kernel.org> <Yhofs/PbIOmiyNIH@latitude>
Subject: Re: [PATCH v2 0/7] clk: Declare mux tables as const u32[]
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date:   Fri, 11 Mar 2022 18:33:35 -0800
User-Agent: alot/0.10
Message-Id: <20220312023337.62A25C340E9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-02-26 04:40:19)
> On Fri, Feb 25, 2022 at 05:00:31PM -0800, Stephen Boyd wrote:
> > Quoting Jonathan Neusch=C3=A4fer (2022-02-05 02:36:06)
> > > I noticed that the 'table' parameter to clk_register_mux_table is nev=
er
> > > used for modifying the table elements, and so it can be declared cons=
t.
> > >=20
> > > In version 2 I'm addressing two warnings in the clk-lpc18xx-cgu driver
> > > that I previously missed.
> >=20
> > The format of these patches deeply confused my scripts that use git
> > interpret-trailer. I fixed it now, hopefully it keeps working. In the
> > future, please don't add more triple dash '---' sections to the patch.
> > It looks like those extra sections for the changelog messed everything
> > up. Or there's a new bug in interpret-trailers.  Either way,
> > interpret-trailers was adding tags after the entire patch contents
> > because I think it looks for the last triple dash instead of the first
> > triple dash. Not sure why it's done that way. I resorted to
> > reconstructing the patch after splitting it with mailinfo.
>=20
> Hmm, sorry about that.
>=20
> I've used this format for a while, because it conveniently lets me
> keep my remarks in a git commit (rather than a patch file), until I use
> git format-patch to generate the final patch file.
>=20
> I'm not very familiar with git interpret-trailers, but git 2.34.1
> doesn't seem to get confused on my patches (or I didn't pass the right
> options to cause it to happen).
>=20

It's possible it's a git bug. No worries!
