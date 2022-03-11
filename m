Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2320C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 10:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347945AbiCKKfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 05:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiCKKe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:34:57 -0500
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2FFF406D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:33:54 -0800 (PST)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 14DFC21516;
        Fri, 11 Mar 2022 10:33:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 427BB20017;
        Fri, 11 Mar 2022 10:33:52 +0000 (UTC)
Message-ID: <6b97a143521840de469c0bb37543c16e362059b1.camel@perches.com>
Subject: Re: [PATCH v3 10/10] maintainers: Introduce HPE GXP Architecture
From:   Joe Perches <joe@perches.com>
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 11 Mar 2022 02:33:51 -0800
In-Reply-To: <20220310195229.109477-10-nick.hawkins@hpe.com>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
         <20220310195229.109477-10-nick.hawkins@hpe.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bfkwk6pj8c7jon1n7pbwyhsh7t4g1mck
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 427BB20017
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19lvNpNbuZ7LjzNBpxfOrnb9R/9zdZ8qSE=
X-HE-Tag: 1646994832-405298
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-10 at 13:52 -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Create a section in MAINTAINERS for the GXP HPE
> architecture.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -8791,6 +8791,20 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Orphan
>  F:	drivers/platform/x86/tc1100-wmi.c
>  
> +HPE GXP ARCHITECTURE
> +M:	Jean-Marie Verdun <verdun@hpe.com>
> +M:	Nick Hawkins <nick.hawkins@hpe.com>
> +S:	MAINTAINED

Use the case sensitive version instead

S:	Maintained

$ git grep -h '^S:' MAINTAINERS | sort | uniq -c | sort -rn
   1682 S:	Maintained
    637 S:	Supported
     71 S:	Odd Fixes
     64 S:	Orphan
     19 S:	Odd fixes
      7 S:	Orphan / Obsolete
      2 S:	Obsolete
      1 S:	Buried alive in reporters


