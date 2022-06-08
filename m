Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBB1C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 03:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiFHDkF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 23:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbiFHDfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:35:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAB721628F;
        Tue,  7 Jun 2022 17:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9A306187F;
        Wed,  8 Jun 2022 00:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8ACC341F8;
        Wed,  8 Jun 2022 00:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654649251;
        bh=ZskClJ6YsWVHejtgkKujPrrb7TJaJgflzOhkbxSLtFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vmq2cjcGwoPB/8iv/5DnovPl8yo7M2lo6Ms+GtKh37ybTLOTFFnxXKshOpH4WZiRj
         AlrFUemLwZLWVjuJZL3P+2y2IsVq8RcTZBERqt6zWtDYpoTXmagd7EJPjduMIv9E6G
         shEB00JHIUITxEZrWcLzND3MY29Kxwn/P120e+lvdlfC3xLnlYxGTJxVgknx2KhZJv
         xeVcaYmWkIFtk75MtBVH3nclLLrNlf2AoafmS4LT3jTV5ZDg+Wjz13OgZu/sesqRdM
         YIfy1j1eRkSsk5YVBnioAkiqwYJq5JmNCqm5gFEAvMWkD3oCMy0aOz9Kj7avf09/5D
         iEgDDeu/N+lAg==
Date:   Tue, 7 Jun 2022 17:47:30 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Willy Tarreau <w@1wt.eu>, Heiner Kallweit <hkallweit1@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Florian Fainelli <f.fainelli@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com, rui.zhang@intel.com,
        yu.c.chen@intel.com
Subject: Re: [net]  6922110d15: suspend-stress.fail
Message-ID: <20220607174730.018fe58e@kernel.org>
In-Reply-To: <20220605143935.GA27576@xsang-OptiPlex-9020>
References: <20220605143935.GA27576@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jun 2022 22:39:35 +0800 kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 6922110d152e56d7569616b45a1f02876cf3eb9f ("net: linkwatch: fix failure to restore device state across suspend/resume")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: suspend-stress
> version: 
> with following parameters:
> 
> 	mode: freeze
> 	iterations: 10
> 
> 
> 
> on test machine: 4 threads Ivy Bridge with 4G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> Suspend to freeze 1/10:
> Done
> Suspend to freeze 2/10:
> network not ready
> network not ready
> network not ready
> network not ready
> network not ready
> network not ready
> network not ready
> network not ready
> network not ready
> network not ready
> network not ready
> Done

What's the failure? I'm looking at this script:

https://github.com/intel/lkp-tests/blob/master/tests/suspend-stress

And it seems that we are not actually hitting any "exit 1" paths here.
