Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6652DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 21:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiB1VZ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 16:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiB1VZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:25:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABCF121522;
        Mon, 28 Feb 2022 13:24:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6052261152;
        Mon, 28 Feb 2022 21:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50E7C340F1;
        Mon, 28 Feb 2022 21:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646083485;
        bh=fu/dnEmqFSyXKID1VD4bFK7+fp4UW+/J+9UZTgdAkFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WN2g5IDXNi/135TrH1b/xhDr21EzPPi+2C2HL8l2DLC0WN4tZlJipQu+sIn7gSQhx
         E2gW7TyT05jKqLp2AYd+Mrpg0nwFinhHnAmXeSq1Gm+7Pa21qD93rcwTFnVP3jXncI
         bnEV+yLULEMeckMvQTRQsONZw0sgblGTIcaEW/J4h3PFqQAdeahQPoi+yTn66QHJZY
         s1erIEANtCbs5l6sfR6DE7cTmBB6CM2cF2B7XuQ6j4jrXiyCdu7RSbLHZFzfndAu1J
         eGVg4fVJWfHUnqGSPwAluBiOEWLMyNHKRJqXKjrsHCmoQcCEY6lrdJ7E2uR2fvMIP/
         hMsXCZCxKzdOw==
Received: by mail-ed1-f52.google.com with SMTP id s24so19435696edr.5;
        Mon, 28 Feb 2022 13:24:45 -0800 (PST)
X-Gm-Message-State: AOAM530dSx+KyRUYHie6kOENWCZj3GnTl/izOnaGDt2BvhC89QtbpleS
        0Gqu2tVCrNsG1BqXEef9Dih5u84ndPeslt5cEw==
X-Google-Smtp-Source: ABdhPJw6dmtTyckD2gF5I1BitkqCJhhSY+2RRu5a7CXHFUyi59AMH5lvtiV0DeTGMOqwMH+01hD5mqDtnrnu4xMDfAw=
X-Received: by 2002:aa7:d98a:0:b0:410:b844:7889 with SMTP id
 u10-20020aa7d98a000000b00410b8447889mr21271791eds.109.1646083484031; Mon, 28
 Feb 2022 13:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20220201181413.2719955-1-frowand.list@gmail.com>
In-Reply-To: <20220201181413.2719955-1-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 28 Feb 2022 15:24:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKrWQ1Jn2HCxFsPKYcPXbYUgyPytvc_YrS=sgkWHv1hZA@mail.gmail.com>
Message-ID: <CAL_JsqKrWQ1Jn2HCxFsPKYcPXbYUgyPytvc_YrS=sgkWHv1hZA@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: unittest: add program to process EXPECT messages
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 12:14 PM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> If unittest detects a problem it will print a warning or error message
> to the console.  Unittest also triggers warning and error messages from
> other kernel code as a result of intentionally bad unittest data.  This
> has led to confusion as to whether the triggered messages are an
> expected result of a test or whether there is a real problem that is
> independent of unittest.
>
> EXPECT messages were added to unittest to report each triggered message
> that is expected, resulting in verbose console output.
>
> scripts/dtc/of_unittest is a new program that processes the EXPECT
> messages to determine whether the triggered messages occurred and
> also removes the excess verbosity of the EXPECT messages.  More
> information is available from 'scripts/dtc/of_unittest_expect --help'.
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> permissions for scripts/dtc/of_unittest should be 770

Why? 755 is what the patch says and what most/all executables in the kernel are.

Rob

>
> I will reply to this message with the usage message from
> 'scripts/dtc/of_unittest_expect --help'.
>
> I will also reply with examples of raw and processed console logs.
>
>  Documentation/devicetree/of_unittest.rst |  27 +-
>  scripts/dtc/of_unittest_expect           | 408 +++++++++++++++++++++++
>  2 files changed, 432 insertions(+), 3 deletions(-)
>  create mode 100755 scripts/dtc/of_unittest_expect
