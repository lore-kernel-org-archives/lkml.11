Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A246FC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 00:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiGTAtX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 20:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238777AbiGTAtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 20:49:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CA950078;
        Tue, 19 Jul 2022 17:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC635B81DD6;
        Wed, 20 Jul 2022 00:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D682C341C6;
        Wed, 20 Jul 2022 00:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658278156;
        bh=dIaExzjLQwCMa+c5XJJ2EQEFfNaaQkyJh6Cm5aHnsEc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mxyqy8s+XANTOgym8JECEJ/hEwoVihsLLxln6+k06zq2A2HLApchWHlVSJKVqOayt
         RrZxM3ZfBmHtIni0+PAOgO1dioXDGUIWL26drPUTjzzEu25VmOIBxfZNOx5W6jpUMb
         ZLp+WRRtNamhboH+bDjQ/eLAtyIdkXz7c3FnX9CVF4LQAPgu2cDMekNGh3RhxsV4TM
         vW1ol5MOQJhMI1Pt659Th1qcj1B1o5B3q5FNq7SQSKK6CHZxlsy34tJj1N2cmaMa7T
         ig0jPetotxkdBhh+2SZkuHltDzIVdAaPvWIcSZz4yzwATvttIwo9+OTn+CXMFrHoG7
         UAm8SthveGIUw==
Date:   Tue, 19 Jul 2022 17:49:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     LemmyHuang <hlm3280@163.com>
Cc:     edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: fix condition for increasing pingpong
 count
Message-ID: <20220719174915.48f830b4@kernel.org>
In-Reply-To: <20220719130136.11907-1-hlm3280@163.com>
References: <20220719130136.11907-1-hlm3280@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 21:01:37 +0800 LemmyHuang wrote:
> -	if (before(tp->lsndtime, icsk->icsk_ack.lrcvtime) &&
> +	if ((tp->lsndtime <= icsk->icsk_ack.lrcvtime) &&

Are you sure you don't need to take care of the values wrapping?
before() does that. You may want !after() if you want to allow equal.
