Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572F4C3F6B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 00:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiHYAgv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 20:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiHYAgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 20:36:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E884ECF
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 17:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=fklRrjV9yUeNECa0TwWmaGNUeOqWz4zg/ddmBlOBBTU=; b=ZCC6OZuBjQQVzdEw4mEhWFGSdl
        2k79r0XYHyiPiOBjqjjSNIfebC4khSoCDt2lyQNQVKSap5eaqR9fyl7pN92tHqjqClRJIyEF/KuVw
        Y2z0cTsJ9Rh/lavSEJ7S4jaF1JBT82e1lmc+OME1n3QXW3+ZuY3aAa9gHM1E939FFyz4IxOWSs44B
        VNboHd0GN8dcUkbyakl3sEzHANw8mWSCLJonLKARkZrK6ak9hdSeEajyWf+lSRh7wlqHCpVKKDAbS
        Cj5+ztDSjBNELM2tHrTr8IxM1kwjDwzjLx2GrB2w6+Pthz/fatTYKDZiS2ew5c2/XizsPQBONtDc/
        4V5Dgaww==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oR0rW-003Xa7-3k; Thu, 25 Aug 2022 00:36:46 +0000
Message-ID: <07ad2ab8-ed96-21a6-8ace-e5f168712872@infradead.org>
Date:   Wed, 24 Aug 2022 17:36:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH] compat: update linux/compat.h and kernel/sys_ni.c
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20220822194310.31796-1-rdunlap@infradead.org>
 <20220822134614.aeb6f3ce279ded4559037de1@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220822134614.aeb6f3ce279ded4559037de1@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/22 13:46, Andrew Morton wrote:
> On Mon, 22 Aug 2022 12:43:10 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Add conditional syscalls entries in kernel/sys_ni.c
>> for any syscalls that are arch- or config-dependent.
> 
> What is the reason for this?  What effects does it have?

Hi Andrew,

For <linux/compat.h> it's mostly a cleanup/completeness change,
as suggested by Arnd here:
  https://lore.kernel.org/lkml/CAK8P3a140FFhCvrOXbCtYKCW6BR6tEz6uy8Wqd0aG3DdHiZSXg@mail.gmail.com/


For kernel/sys_ni.c, it adds compat syscalls that are arch- or
config-dependent, to prevent the possibility of linker errors.

I have successfully built allnoconfig, defconfig, and allmodconfig for around 20
architectures with this patch applied.

-- 
~Randy
