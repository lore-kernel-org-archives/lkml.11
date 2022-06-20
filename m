Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB7CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 14:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244598AbiFTOjr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 10:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348394AbiFTOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:38:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67682A1;
        Mon, 20 Jun 2022 06:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8669BB80EA6;
        Mon, 20 Jun 2022 13:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C85C3411B;
        Mon, 20 Jun 2022 13:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655733290;
        bh=0Zhtxbgb+akc5i+LjMc0sF526d+LBvTZ8zqGUTfm/TM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jHimN9yGrIvEPjZHz0UJPPXbeEp1Z0dgTpG0GogBI+3NXR6bwNPrJHDeaMO/ckFJW
         VNn+GSRVf5L9QHpn56ZwagnBU7mHjEV5gECCf5PGGYl43ET3PQt0//elTSlm6BQDgM
         iZVYil4RZWXJiZsi6OYLyI7u2cI9267mDQc89iSA=
Date:   Mon, 20 Jun 2022 15:54:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.18 081/141] net: remove noblock parameter from
 skb_recv_datagram()
Message-ID: <YrB8Jpk9FUqIxT/1@kroah.com>
References: <20220620124729.509745706@linuxfoundation.org>
 <20220620124731.932460774@linuxfoundation.org>
 <04920243-e585-edf6-a849-cfa5a2ff6ba1@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04920243-e585-edf6-a849-cfa5a2ff6ba1@hartkopp.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 03:44:08PM +0200, Oliver Hartkopp wrote:
> Hello Greg,
> 
> as already answered to Sascha:
> 
> ---
> 
> Hello Sasha,
> 
> this patch is some kind of improvement/simplification to reduce and clean up
> the number of variables passed through skb_recv_datagram() call.
> 
> There is no functional change and therefore no need to backport this patch
> IMO.

It is needed by a follow-on patch that fixes a real issue.

thanks,

greg k-h
