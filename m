Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EE1C04AA5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 03:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiHYDZE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 23:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiHYDY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 23:24:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A4CE0C9;
        Wed, 24 Aug 2022 20:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=kAyZ4aFeZ0Yw1IAfoAl3xil1/0OSmPLUEfdAGELoED4=; b=T29woqf4bFI76dJnO9ofWAT8bN
        ZiQtEQtdBKbZLTCt5DV/+MLYf/BD12K4SGNZzAR/fyBbXFDOnTbLaE1OCDsZH0JJhVw5edHMSJ3ND
        H/0aOILhsjZc+gmpWOvRSBU5cMnw/W+dQrD73cLZ6vEyAyAdQWr4OMwu809uBOW7yb4zRzphN6kzP
        VAupObRDxcWSWULcPCYNHZV85o1Wetvm82H+rr2mh7xJPG/5VXx5v3VVTld+2mcg97wa5PYP9DGCF
        dBMUx4H3Gm0+G9CE5xTfg5Fi/rDE5EEpaHtiLAFbimkBOW0utZI5gj9//88u7A61XOCJXXlnnFWfK
        zsOXMT0g==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oR3UB-005ENr-38; Thu, 25 Aug 2022 03:24:51 +0000
Message-ID: <d5eca4a6-8a76-02e0-2f22-645341af8c2b@infradead.org>
Date:   Wed, 24 Aug 2022 20:24:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] docs: Update version number from 5.x to 6.x in README.rst
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
References: <20220824080836.23087-1-lukas.bulwahn@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220824080836.23087-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/22 01:08, Lukas Bulwahn wrote:
> A quick 'grep "5\.x" . -R' on Documentation shows that README.rst,
> 2.Process.rst and applying-patches.rst all mention the version number "5.x"
> for kernel releases.
> 
> As the next release will be version 6.0, updating the version number to 6.x
> in README.rst seems reasonable.
> 
> The description in 2.Process.rst is just a description of recent kernel
> releases, it was last updated in the beginning of 2020, and can be
> revisited at any time on a regular basis, independent of changing the
> version number from 5 to 6. So, there is no need to update this document
> now when transitioning from 5.x to 6.x numbering.
> 
> The document applying-patches.rst is probably obsolete for most users
> anyway, a reader will sufficiently well understand the steps, even it
> mentions version 5 rather than version 6. So, do not update that to a
> version 6.x numbering scheme.

Yeah. And I suspect that scripts/patch-kernel is even more obsolete
than applying-patches.rst.

> Update version number from 5.x to 6.x in README.rst only.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/admin-guide/README.rst | 30 ++++++++++++++--------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Bagas- I don't have a problem with this patch.

If it could be automated easily, that would be OK too.

Or I might add that v6.x patches are located at
https://mirrors.edge.kernel.org/pub/linux/kernel/v6.x/

and v5.x patches are located at
https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/

thanks.
-- 
~Randy
