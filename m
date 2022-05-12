Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A22C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 23:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359395AbiELXNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 19:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359384AbiELXNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:13:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E1014AC85;
        Thu, 12 May 2022 16:13:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9843362032;
        Thu, 12 May 2022 23:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13DBC385B8;
        Thu, 12 May 2022 23:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652397179;
        bh=YrHyNooh+9xg1ifmHbZjruMIOFBDmwBmoHnshNnE6xs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eYi9KKU7D8PB+ECU356yHEvxwRpMIwcjUSvF8cE8bYy+Eq5XO83JfcOvgYTG9KRjM
         ogGN6u2VuCkW4DG0+JPz4c4VmUx+gwTOhCRzvidvmkoWSh3ZUMJ/7pH0WbCD+ZDC2r
         OHjhN6+fwJBJbmUOb6IrgSfNTYyL5qePmbEzJFL7BU7UNikqzNNNItgZLW+qdBth72
         N4NAfQR2S4FsA7uOU+H+YWo2DutT87vL08Z4odLJ7/u9zxFQKs3Ic03yv2iQJ7QIQl
         nKl/Qy+oHdHs7aLB7kv5+LiW0acPY/9Rhs4d5vCAS/kAS4UNoWdEbeUhA+kM5IPiDT
         9YDEZBo/evqZA==
Date:   Thu, 12 May 2022 16:12:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Joe Damato <jdamato@fastly.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC,net-next,x86 0/6] Nontemporal copies in unix socket write
 path
Message-ID: <20220512161257.016b4b71@kernel.org>
In-Reply-To: <20220512225302.GA74948@fastly.com>
References: <1652241268-46732-1-git-send-email-jdamato@fastly.com>
        <20220511162520.6174f487@kernel.org>
        <20220512010153.GA74055@fastly.com>
        <20220512124608.452d3300@kernel.org>
        <20220512225302.GA74948@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 15:53:05 -0700 Joe Damato wrote:
>  1. Do you have any strong opinions on the sendmsg flag vs a socket option?

It sounded like you want to mix nt and non-nt on a single socket hence
the flag was a requirement. socket option is better because we can have
many more of those than there are bits for flags, obviously.

>  2. If I can think of a way to avoid the indirect calls, do you think this
>     series is ready for a v1? I'm not sure if there's anything major that
>     needs to be addressed aside from the indirect calls.

Nothing comes to mind, seems pretty straightforward to me.
