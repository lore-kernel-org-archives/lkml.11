Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D78DECAAA1
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 07:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiIBHDM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 03:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiIBHDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:03:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ECEBC813
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:03:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8149B829EA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CF7C433C1;
        Fri,  2 Sep 2022 07:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662102186;
        bh=YyWJyhjcgghGxYhOkC8ahoD6cFG8bpuWcSdNANs2bKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YEpz/kQazWWhaW7bT/aZVfIQpyXKf50Jb5HpkShaXJEdEdU9OoKHrTDggox8xY15w
         j5x47/Qzcx/eE6t4+suByReo4e47VgywmUQk9YCsiVyRYjXcb2MQCedd6l4sCQYWyk
         LelZHWF9iuTqTXncV8zB3yPt+lBQdAGSpZiZZkfM=
Date:   Fri, 2 Sep 2022 09:03:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: Soundwire fixes for v6.0
Message-ID: <YxGqp4XCEr/+lnFC@kroah.com>
References: <YxGeD1ZoLB/IOB4x@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxGeD1ZoLB/IOB4x@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:39:19AM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive two fixes for qcom driver. Both of these are in
> linux-next.
> 
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> 
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.0-fixes

Pulled and pushed out, thanks.

greg k-h
