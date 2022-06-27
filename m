Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D12C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 15:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbiF0P6O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 11:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbiF0P5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:57:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D2B26D1;
        Mon, 27 Jun 2022 08:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9100261614;
        Mon, 27 Jun 2022 15:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD6DC3411D;
        Mon, 27 Jun 2022 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656345458;
        bh=47B2S+NQxg9Di9pAJ3CMrVeOst64ifs5AvtyZhGOVks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZfuYqDlBbkUq/1HNYGX0wyiQF4hgX1r/gvpjFo7aPNwM9K2SLGdh1ezeZ8QDTmi1e
         5OfrgbB5E05IXsaWD2M9REnnxyqMwVYpXsnGNJOCjFGT+9G14qYoMTFPzeOFy95z7p
         Q45K47vza5YfugjGhwQoqt+dq7FvKFnxoLAxHq1iQ5gGCAXZxHBj/oz9JMXp3cNpwZ
         YGXms6++fPBrvE9Y/gJfwwv1vzZrFmJsyy1YXWIKmSHOCWKuCd4K0iCWIXR/OEYnuN
         CU7m+OzClQju5QoYmBtTe67wgI3Sr5/jP5NLqDA9jK+fmeD+ypYKGqg6yvSDwCbK48
         ftA6/4B1QbuAQ==
Date:   Mon, 27 Jun 2022 08:57:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.18 097/181] Revert "net/tls: fix tls_sk_proto_close
 executed repeatedly"
Message-ID: <20220627085728.643737fb@kernel.org>
In-Reply-To: <YrnRxxAUbk8fdjac@kroah.com>
References: <20220627111944.553492442@linuxfoundation.org>
        <20220627111947.372126973@linuxfoundation.org>
        <20220627083313.285787a5@kernel.org>
        <YrnRxxAUbk8fdjac@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 17:50:31 +0200 Greg Kroah-Hartman wrote:
> On Mon, Jun 27, 2022 at 08:33:13AM -0700, Jakub Kicinski wrote:
> > On Mon, 27 Jun 2022 13:21:10 +0200 Greg Kroah-Hartman wrote:  
> > > From: Jakub Kicinski <kuba@kernel.org>
> > > 
> > > [ Upstream commit 1b205d948fbb06a7613d87dcea0ff5fd8a08ed91 ]
> > > 
> > > This reverts commit 69135c572d1f84261a6de2a1268513a7e71753e2.
> > > 
> > > This commit was just papering over the issue, ULP should not
> > > get ->update() called with its own sk_prot. Each ULP would
> > > need to add this check.
> > > 
> > > Fixes: 69135c572d1f ("net/tls: fix tls_sk_proto_close executed repeatedly")
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> > 
> > Mm? How did 69135c572d1f get into stableh? 
> > I reverted it before it hit Linus's tree.
> > Don't see the notification about it either.  
> 
> It is commit 075/181 in this series as you can see here:
> 	https://lore.kernel.org/r/20220627111946.738369250@linuxfoundation.org

Argh, I forgot I'm not gonna get CCed if my tags aren't on the
commit in question, sorry for the confusion.

So I expected patches 075 and 097 would just get dropped since
they are in the same series and are canceling each other out. 
But I guess people may edit reverts so you prefer not to 
automatically do that?
