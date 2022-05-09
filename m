Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8A5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 22:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiEIWKj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 18:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiEIWKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:10:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20DE1EE0A7;
        Mon,  9 May 2022 15:06:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7D0DB732;
        Mon,  9 May 2022 22:06:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7D0DB732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1652134001; bh=QMy1D0TjaS0SUmscSgDn3kEr8C3vCmkqenPKxihq2+o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XLUeiprmgfmpXzYmKVfWshBJLVx6a+FCdkyuErEXVrna/bzzrQMZIx9UA/9Qot8po
         nVDWvP98O5UviRsvWysTByBzbXo9A+e+/V0wgwLu/fKsM9BEvQlTNi238F2EVySeTz
         cac6uOmg3c6dlJfVvolqt5zFgaYXPapgZEuL9dawmHDmQef9sJEWFv9SgU/aVufS3/
         8Ly1U/UI9vekR3j0h5wTpOU28Ssofor3kWMM5U+rymZ4F+XPphiFbfw7COQUmeGdsa
         r3ek+qgiq+XXP+XTALUPgjqWMR2Bur4GPH0WSiLCRAD83e6wYKxjOr1o+fboXlj4EB
         N158tiK85HyCQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        shibata@linuxfoundation.org
Cc:     Kosuke Fujimoto <fujimotokosuke0@gmail.com>, akiyks@gmail.com,
        skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5]     docs/trans/ja_JP/howto: Don't mention specific
 kernel versions
In-Reply-To: <20220501102256.6379-1-fujimotokosuke0@gmail.com>
References: <20220501102256.6379-1-fujimotokosuke0@gmail.com>
Date:   Mon, 09 May 2022 16:06:40 -0600
Message-ID: <87k0aucqdr.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kosuke Fujimoto <fujimotokosuke0@gmail.com> writes:

>     This change is based on commit d2b008f134b7
>     ("Documentation/process/howto: Update for 4.x -> 5.x versioning").
>
>     Replace "4.x kernel version" with generic term such as "mainline tree"
>
>     Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
>     Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
>     ---
>     V2: Reformatted commit log message (Yokosawa-san)
>     V3: Updated some expressions (Shibata-san)
>     - added "version number" in mainline tree section
>     - updated from "stable kernel" to "stable tree"
>     V4: Added reviewed by tag and removed extra characters (Yokosawa-san)
>   =E3=80=80V5: Removed an extra character (Shibata-san)
> ---
>  Documentation/translations/ja_JP/howto.rst | 44 +++++++++++-----------
>  1 file changed, 21 insertions(+), 23 deletions(-)

Applied, thanks.

jon
