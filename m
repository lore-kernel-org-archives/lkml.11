Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306DDC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 05:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiGOFEC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 01:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiGOFEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 01:04:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22F61145E;
        Thu, 14 Jul 2022 22:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5237CB82A85;
        Fri, 15 Jul 2022 05:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AE0C34115;
        Fri, 15 Jul 2022 05:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657861435;
        bh=fFOZ2QzkvKd/jKVejX3LNzrlqdqndE/DUem9MSI4ERQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q/hPjHxmN4m2iBUSbGYOngkppkZnTqnWwxMTrcSwtlIRKW5eVebuXOAphjvIAtCJK
         kfW6DzdowVnXZmgXCaICA7ceW9s3Ceh6HEaEAGOK9438j+qwLanmCbfsHl+4KVDlXG
         xynKwU3/K/DClc6ofbByJjd+vpB6AGggypmlKrJroTa3yISkWoWGuhFOE8Z/D7nwLq
         Rea+zpsZiTqzrENHJAAnESKIruxF4DOf16aQxZ55dKig61i4Zulok9e9KhhF1YY6gt
         F6nm4hnGkqOjvBRoSERjxCxf0R1I5HgTv3WMT+lSlRFco0Sity+bFYVjzMlnxl0lw4
         LsuSWl2tKMXww==
Date:   Thu, 14 Jul 2022 22:03:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: dsa: qca8k: move driver to qca dir
Message-ID: <20220714220354.795c8992@kernel.org>
In-Reply-To: <20220713205350.18357-1-ansuelsmth@gmail.com>
References: <20220713205350.18357-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 22:53:50 +0200 Christian Marangi wrote:
> This is a start for the required changes for code
> split. Greg wasn't so negative about this kind of change
> so I think we can finally make the move.
> 
> Still waiting some comments about the code split.
> (Can I split qca8k to common function that will be
> used by ipq4019? (and later propose the actual 
> ipq4019 driver?))

Does the split mean that this code will move again?
If so perhaps better to put this patch in the series 
that does the split? We're ~2 weeks away from the merge 
window so we don't want to end up moving the same code
twice in two consecutive releases.
