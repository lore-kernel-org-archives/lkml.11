Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA55DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 22 May 2022 10:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiEVKGf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 May 2022 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiEVKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 06:06:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802FD36175;
        Sun, 22 May 2022 03:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CE1CB80AC0;
        Sun, 22 May 2022 10:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62A4C385AA;
        Sun, 22 May 2022 10:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653213988;
        bh=UPbiNgGAwL5aqC80FZUlkF31vbhQbeH7p2NfiK7RD2M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eA61M92tHgqSHqaH2+zWhVTbhBium3ZcdMEvpGQ2mcCdkiV08IntwH/YZspjp9Y6p
         l77Ybc5invmaeox5YhBnkU/2tDJHj2cncl+YbuxTshEaZ+N6GINcx49jQsdTWe1NR4
         XYDq3wSJH2EqNJd1zRAWsoDSsAlSFCkpqeZMqOI+9qSkU7NtluM+Iee7bibENAYuaC
         pI4xjE4EWVvCDlPBGKaXFkskkpsoFyzNg7MsN7KowN/tFErtrwCzsGimQT77RUGAPI
         0pmfvuiGnjRRsCUGDwf0uPhz8j3sxgS35sQSbBDFmrqEs7wKFhm55JSHTrFxYEle8w
         Kb5FTKuQm3M4Q==
Message-ID: <30ab0c63-4576-a9a1-8dd2-aa0e79ddd59f@kernel.org>
Date:   Sun, 22 May 2022 18:06:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] f2fs: fix typo in comment
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220521111145.81697-93-Julia.Lawall@inria.fr>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220521111145.81697-93-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/21 19:11, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
