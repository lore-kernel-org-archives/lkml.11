Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC83C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 16:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbiGNQ2E convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 12:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239053AbiGNQ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:27:56 -0400
Received: from relay5.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1033562A51
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:27:56 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id 8A3AB60126;
        Thu, 14 Jul 2022 16:27:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 1BC6220027;
        Thu, 14 Jul 2022 16:27:52 +0000 (UTC)
Message-ID: <3bd7e3d14c63a50d869ab10fcba4fd93d17745c0.camel@perches.com>
Subject: Re: [PATCH net-next] net: prestera: acl: fix code formatting
From:   Joe Perches <joe@perches.com>
To:     Maksym Glubokiy <maksym.glubokiy@plvision.eu>,
        Taras Chornyi <tchornyi@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Jul 2022 09:27:52 -0700
In-Reply-To: <20220714161704.2370010-1-maksym.glubokiy@plvision.eu>
References: <20220714161704.2370010-1-maksym.glubokiy@plvision.eu>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: ri8f6md636nzmezryufjhr5qz9mb498k
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 1BC6220027
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/x9wSdw6fs9vKhTg30/+ToOlxtc4sa3yg=
X-HE-Tag: 1657816072-806075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-14 at 19:17 +0300, Maksym Glubokiy wrote:
> Make the code look better.
> 
> Signed-off-by: Maksym Glubokiy <maksym.glubokiy@plvision.eu>
> ---
>  .../net/ethernet/marvell/prestera/prestera_flower.c    | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_flower.c b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
[]
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> -/* Copyright (c) 2020 Marvell International Ltd. All rights reserved */
> +/* Copyright (c) 2020-2022 Marvell International Ltd. All rights reserved */

What gives you the right to extend Marvell's copyright?

In general, don't change copyright for whitespace changes
and unless you are the copyright owner.

