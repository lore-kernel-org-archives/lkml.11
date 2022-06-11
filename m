Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0549C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jun 2022 00:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344032AbiFKARd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 20:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiFKAR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 20:17:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2C3248
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 17:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAAF261E59
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 00:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26924C34114;
        Sat, 11 Jun 2022 00:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654906648;
        bh=x+7FaFW/vNwK+pUHUyn6tvqv2InhgiiGULVDA42+Wz8=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=uO9pdv0rh8LOxhK1rYxPigrLzCjhDVgcb3GNcFeHiyM6Z+xKMIc2Hr69PZcR0VElz
         I0rMgj+rfnmxvdU4Ht8yuuASWM+URBqrC9/sMbXwClfWTdHi7bcvnj06Qp2VpUSGzg
         2mn5GXRhuciEvmCowekNL6qCY4sbo5/5nCiTcnx0rXPUVLtZNUqsblJE+27NJnwqm5
         fGgBXRnxeNEJfGYrBndoW7DjlOlFjX8chxh+UC2iYeKXti58HULiFZcGK6qZNk/rtQ
         xGkHevdSE39hPyz/FI74vtel0iX9yRGEZ/TV5+zR4Tk9VXG98TkEoP8txmCydtieVB
         dVHa4fjvM6/tg==
Message-ID: <79570915-c8fe-e3d4-ba61-0647c3d72dd0@kernel.org>
Date:   Fri, 10 Jun 2022 17:17:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vineet Gupta <vgupta@kernel.org>
Subject: Re: [PATCH] ARC: Fix syntax errors in comments
To:     Xiang wangx <wangxiang@cdjrlc.com>, vgupta@kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220603130141.6516-1-wangxiang@cdjrlc.com>
Content-Language: en-US
In-Reply-To: <20220603130141.6516-1-wangxiang@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/22 06:01, Xiang wangx wrote:
> Delete the redundant word 'to'.
> Delete the redundant word 'since'.
>
> Signed-off-by: Xiang wangx<wangxiang@cdjrlc.com>


Thx for the fix. Added to for-curr

-Vineet
