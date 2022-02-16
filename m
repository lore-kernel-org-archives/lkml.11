Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F9DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 23:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiBPXeU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 18:34:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbiBPXeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:34:18 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AD1235862;
        Wed, 16 Feb 2022 15:34:01 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3FEE237D;
        Wed, 16 Feb 2022 23:34:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3FEE237D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645054441; bh=/FG0LeNHqOYvL0HTZM/CzmhvlOdBcPFFnjhPomcXYzw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XXeCjFv1NWE1nYw88j9ruFwFCSaWNl/4vtSFo3GFMZ6cMHBG7CRuskHcEbT6APfKD
         TLr69OFt2pILLpzfC9Jxvg2RsVPgI7j4CSs7u64/vVSMZx/nIHJji1Ta7Djp2tU2l6
         BoslnAHvT6GmBmDhKbKFsSx46SkMg41TfHX0anJv4wQzD6c2BjfMiBacL4jq5XsUgK
         rRWYQ9z4gbakhKFvv5/Tq+JIQusDCeRao8PL64Ca+g2by1xl/uITOjuWfAamAt5yJ5
         3oIsL/zomeLOGLzrSudN8uimF/fs8Rn+aVVq6YHdCll4/Kt9Ex8xQEURDxmgAzgzA4
         +3X/ROC7dUVNw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/15] scripts: kernel-doc: Refresh the copyright lines
In-Reply-To: <20220104015946.529524-15-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
 <20220104015946.529524-15-tomasz.warniello@gmail.com>
Date:   Wed, 16 Feb 2022 16:34:00 -0700
Message-ID: <87bkz62xp3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

> I'm not sure, why these notices need to stay at the top, but that's what
> Jonathat Corbet replied to my version 1.

Because that's how we do things with kernel code.

> Anyways, I've cleaned them up a little. Looks good?
>
> My name's included as the refreshing force of this venerable script.

Not sure if the text movement done so far crosses the bar where
copyright can be asserted or not...but I doubt anybody cares enough to
fight you on it :)

> * Transform documentation into POD (14/15)
> See step 1 for the series details.
>
> (Still not sure about this tag line, so please correct, let me know, etc.)
>
> Suggested-by: Jonathan Corbet <corbet@lwn.net>

Responding to review comments doesn't normally require a tag like this
unless the comment led to something new and significantly different.  I
don't think it's needed here.  What you can do is note that you've
responded to the comment below the "---" line.

> Signed-off-by: Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com>
> ---
>  scripts/kernel-doc | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Thanks,

jon
