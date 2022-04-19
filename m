Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32733C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 04:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348236AbiDSEbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 00:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiDSEbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:31:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9617725C4F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AD90B810FD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20CCC385A5;
        Tue, 19 Apr 2022 04:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650342533;
        bh=bDjmhzMYqTgqG2GfbpE8Stb1MOGn045R+b8pIar3cMg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E1lDdzoAgkxozYxF6LYVZLUqlyIMMOfgZG+WFgRVsYR8LcTs1keXlNz8l9pXjHsFz
         1kvh8H53MBi8/toYAja+H8SiSB8TFeLu912iTOxc1bUNGzJb5uA/8aqfFhQP8TWn8j
         sEe9Gx2o52ixuxGiHdvxk6kI1Vwk2EZaXkpAKhPs=
Date:   Mon, 18 Apr 2022 21:28:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     zhanglianjie <zhanglianjie@uniontech.com>, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH sysctl-next] mm: fix unused variable kernel warning when
 SYSCTL=n
Message-Id: <20220418212852.269aa7cd2bb7ecb5aa925f62@linux-foundation.org>
In-Reply-To: <YlnuZrhMc7OydWm7@bombadil.infradead.org>
References: <YlnuZrhMc7OydWm7@bombadil.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 15:15:02 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:

> When CONFIG_SYSCTL=n the variable dirty_bytes_min which is just used
> as a minimum to a proc handler is not used. So just move this under
> the ifdef for CONFIG_SYSCTL.

Acked-by: Andrew Morton <akpm@linux-foundation.org>
