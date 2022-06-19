Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D362FC43334
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jun 2022 00:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiFSAy4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jun 2022 20:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSAyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 20:54:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A00E636F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 17:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF60160DEB
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874FDC3411A;
        Sun, 19 Jun 2022 00:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655600088;
        bh=x7abiCbuk7wG6GSu3AHKJhPYVCZGlCbAAv7OGXYdF0Q=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=OvAsvxp4psgzvMUwuYyixp1E0jUGsrpfqQdfTEpsNMOb2VVMK3uqwwX0JYwd4Siar
         UE52grnjeBe4P3Dcb4oxQJvfqwQEzowGcVjmUBHL8mWglQfqddmIkDJq6PLdO6Czti
         oLcckR0w90VYQ4+VAJsFNbxG3LNS/H0CsEYMEgkXj9aQFhhlESgOz43CHai469QzFC
         2qNi05aEpVR/+m0imTv76+GAGzDBfcBPVyJGK/v/sljnfJU/FKYHrEJYH9uX1HZl5I
         To/8NFGYJ7Bq3CCNjtw5NWLOwHBifm7beUYk/aRjjkMqQEAtMRONWdCZmpskOiEAOm
         jNizIGX7J2Scw==
Message-ID: <d826a043-0e2e-889c-4bae-63738867a3b4@kernel.org>
Date:   Sun, 19 Jun 2022 08:54:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: do not skip updating inode when
 retrying to flush node page
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220617223106.3517374-1-jaegeuk@kernel.org>
 <20220617223106.3517374-3-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220617223106.3517374-3-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/18 6:31, Jaegeuk Kim wrote:
> Let's try to flush dirty inode again to improve subtle i_blocks mismatch.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
