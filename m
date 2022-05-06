Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158C5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 23:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444880AbiEFXEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 19:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444915AbiEFXD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 19:03:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A7C2127A;
        Fri,  6 May 2022 16:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE170619BD;
        Fri,  6 May 2022 23:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B596C385AE;
        Fri,  6 May 2022 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651878012;
        bh=MrL/xlZXbQCHOLcrOHVeYm6Mzr+lMG9w01S/LPD9Ij8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ahhh2SLOWwSBAvNbcv1YVB1jy9Z7m2K0257VVsYEfMzZENURD6400AH0rIKqqnblW
         lhptmKI+EX3WCZsW+/doT+bwf08IjDNMJSMG+UC/iB7e2KDBVaRx/TJi5H1veAmPk+
         3L1N9mLXcOCsZYBME/OZ74Wz+uqX9o8TTnt5xSvOSbqGizHb5xqsT6XldQQf2vDl2W
         4feeV4xtOv6l5VtSgjYD8KQlmIpK0rboaJn7+DGQhPfQby8xZol5opMG9WjJ5hgxA2
         F7ICxxTV26paqmSmKimK8wTuokwJKXTrIp25tMH6VEfIhszeOmO0sOuSO92AWJ66mh
         qjHsMa2+dbxsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F304F03912;
        Fri,  6 May 2022 23:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: chelsio: cxgb4: Avoid potential negative array offset
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165187801205.26496.17417977061407998485.git-patchwork-notify@kernel.org>
Date:   Fri, 06 May 2022 23:00:12 +0000
References: <20220505233101.1224230-1-keescook@chromium.org>
In-Reply-To: <20220505233101.1224230-1-keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     rajur@chelsio.com, lkp@intel.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        bhelgaas@google.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 May 2022 16:31:01 -0700 you wrote:
> Using min_t(int, ...) as a potential array index implies to the compiler
> that negative offsets should be allowed. This is not the case, though.
> Replace "int" with "unsigned int". Fixes the following warning exposed
> under future CONFIG_FORTIFY_SOURCE improvements:
> 
> In file included from include/linux/string.h:253,
>                  from include/linux/bitmap.h:11,
>                  from include/linux/cpumask.h:12,
>                  from include/linux/smp.h:13,
>                  from include/linux/lockdep.h:14,
>                  from include/linux/rcupdate.h:29,
>                  from include/linux/rculist.h:11,
>                  from include/linux/pid.h:5,
>                  from include/linux/sched.h:14,
>                  from include/linux/delay.h:23,
>                  from drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:35:
> drivers/net/ethernet/chelsio/cxgb4/t4_hw.c: In function 't4_get_raw_vpd_params':
> include/linux/fortify-string.h:46:33: warning: '__builtin_memcpy' pointer overflow between offset 29 and size [2147483648, 4294967295] [-Warray-bounds]
>    46 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> include/linux/fortify-string.h:388:9: note: in expansion of macro '__underlying_memcpy'
>   388 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> include/linux/fortify-string.h:433:26: note: in expansion of macro '__fortify_memcpy_chk'
>   433 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:2796:9: note: in expansion of macro 'memcpy'
>  2796 |         memcpy(p->id, vpd + id, min_t(int, id_len, ID_LEN));
>       |         ^~~~~~
> include/linux/fortify-string.h:46:33: warning: '__builtin_memcpy' pointer overflow between offset 0 and size [2147483648, 4294967295] [-Warray-bounds]
>    46 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> include/linux/fortify-string.h:388:9: note: in expansion of macro '__underlying_memcpy'
>   388 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> include/linux/fortify-string.h:433:26: note: in expansion of macro '__fortify_memcpy_chk'
>   433 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:2798:9: note: in expansion of macro 'memcpy'
>  2798 |         memcpy(p->sn, vpd + sn, min_t(int, sn_len, SERNUM_LEN));
>       |         ^~~~~~
> 
> [...]

Here is the summary with links:
  - [v2] net: chelsio: cxgb4: Avoid potential negative array offset
    https://git.kernel.org/netdev/net/c/1c7ab9cd98b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


