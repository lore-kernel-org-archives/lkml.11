Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE5C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 17:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiF1RhP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiF1RhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:37:13 -0400
Received: from relay5.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB8D2DD50
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:37:12 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id D663E35E7B;
        Tue, 28 Jun 2022 17:37:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 58E282001A;
        Tue, 28 Jun 2022 17:37:08 +0000 (UTC)
Message-ID: <59f9c1674f2cd55b8182333ccb75536c365879ea.camel@perches.com>
Subject: Re: [PATCH net-next] MAINTAINERS: Add an additional maintainer to
 the AMD XGBE driver
From:   Joe Perches <joe@perches.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Date:   Tue, 28 Jun 2022 10:37:07 -0700
In-Reply-To: <324a31644b29f7211edb13f26b5ad9ab69a7f0e9.1656422252.git.thomas.lendacky@amd.com>
References: <324a31644b29f7211edb13f26b5ad9ab69a7f0e9.1656422252.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: 3rsjg4t3yibxcw5za9g7crge8xdrgnw7
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 58E282001A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/IRLs7mUKarWI7LRvBAjsy/Z+27Yuw1lw=
X-HE-Tag: 1656437828-789444
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-28 at 08:17 -0500, Tom Lendacky wrote:
> Add Shyam Sundar S K as an additional maintainer to support the AMD XGBE
> network device driver.
> 
> Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -1037,6 +1037,7 @@ F:	arch/arm64/boot/dts/amd/
>  
>  AMD XGBE DRIVER
>  M:	Tom Lendacky <thomas.lendacky@amd.com>
> +M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

While this is a valid email address, get_maintainer assumes
name formats use "first middle last" when parsing a name
before an email address. (look around line 2460 in get_maintainer)

Perhaps this should use quotes around the name like:

M:	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>


