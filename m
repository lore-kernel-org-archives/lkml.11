Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F91C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 13:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346796AbiDKNtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 09:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346709AbiDKNs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714A117A93;
        Mon, 11 Apr 2022 06:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96BAE61139;
        Mon, 11 Apr 2022 13:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA48C385A3;
        Mon, 11 Apr 2022 13:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649684766;
        bh=aKWtMXMYxdsO6I90VlJwQ62Km1pU/xrQPigF44yjuqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Za1uvVJ5WJ79A+NuP3YEjveGAd0yezV5F6zXkRPkcSjWTrdHc+iFtJgf6x1P4IRSJ
         /sxdsPkcNFpQey0mOUSyz2nnZWmzqrmXNITNL1UH735ufifR2neJZuSVPd6QkEXviA
         IXbg9bA217iK5cdKr2+S2PJ6nmu4JTEG+ed6BaG3soLD/gVN6ph2zL1umZzvk/+OVJ
         g1EVG5yMa3aP8ytfvhbBt5068DnnTFQOs5RKn/k6pnCWKMmSLzdiZyMcttevC8Jwo/
         yMjd8RPWqcUHuThAPwFlSLqKGPiNIC65ZxOjR/Ln9uvdfl87AkxkJOqfpjQulX6ztu
         Vl/NCeyp59zGA==
Date:   Mon, 11 Apr 2022 19:16:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] dmaengine: Clarify cyclic transfer residue documentation
Message-ID: <YlQxGh9Jhzm4ekb7@matsya>
References: <20220331134114.703782-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331134114.703782-1-paul.kocialkowski@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-03-22, 15:41, Paul Kocialkowski wrote:
> The current documentation for the residue reported in a cyclic transfer
> case mentions that the reported residue should be relative to the current
> period only. However the definition of DMA_RESIDUE_GRANULARITY_SEGMENT
> specifies that the residue should be updated after each period for
> a cyclic transfer, which is in direct contradiction.
> 
> Moreover the pcm_dmaengine common code uses the residue relative to
> the whole cyclic buffer size, not one period.
> 
> Correct the residue-related documentation to reflect this.

Applied, thanks

-- 
~Vinod
