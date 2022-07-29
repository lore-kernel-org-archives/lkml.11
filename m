Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0947C19F2B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 06:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiG2Gv2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 02:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiG2Gv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:51:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B8877A59;
        Thu, 28 Jul 2022 23:51:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D56B0B826F0;
        Fri, 29 Jul 2022 06:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20803C433D7;
        Fri, 29 Jul 2022 06:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659077482;
        bh=Y+fwoM3j+kiY9u/iHQTKXS3daFS/oyrlt5D21HOO8bQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p5aHYaSNuQT8YvmPv3CGekypBrbbACWkbwsFrk3avT1fqmpYk41KfMDB3X5qbgU3w
         gvJ81jw9fHJRxRYXBWlXEEguxEwBY8iyHQvgbtVkFNdHGdCijHjnWqqhPlJEdb97N8
         yzOyUl8NdCQx0o3pQCILI8SF51SItOihSRLa4lvYaBWPvHSneoleMCh9gi9hjO3tr7
         teVLCXQ01dtW4HVU6rnVWhVN/Vr/Wkl/QtK0tJqkoQjUp4GysPgA1DvK1RuYFcxcTn
         00sLJDMsvwEZqAlFsA3BaEWfxQ96je6QyGQ31PPkJk+P9iYtmlPcXMi85Lr9uI3jTu
         WE6Dj9mPzEWmA==
Date:   Thu, 28 Jul 2022 23:51:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Li zeming <zeming@nfschina.com>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/net/act: Remove temporary state variables
Message-ID: <20220728235121.43bedc43@kernel.org>
In-Reply-To: <YuN+i2WtzfA0wDQb@nanopsycho>
References: <20220727094146.5990-1-zeming@nfschina.com>
        <20220728201556.230b9efd@kernel.org>
        <YuN+i2WtzfA0wDQb@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2022 08:30:35 +0200 Jiri Pirko wrote:
>> How many case like this are there in the kernel?
>> What tool are you using to find this?
>> We should focus on creating CI tools which can help catch instances of
>> this pattern in new code before it gets added, rather than cleaning up
>> old code. It just makes backports harder for hardly any gain.  
> 
> What backports do you have in mind exactly?

Code backports. I don't understand the question.
There's little benefit and we're getting multiple such patches a day.
