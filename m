Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFA3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 13:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiBXNhz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 08:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiBXNho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:37:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FDFF68F0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:37:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE943B82407
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB42EC340E9;
        Thu, 24 Feb 2022 13:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645709828;
        bh=5iJ6NjF03NsxuPxJ694YwbvcZcFiydVzfQ6L9KJvSgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=APcQR+QtL9yy5a2JKfAPmToK5AYKxu6YA2KzrtkqkPuH/8V5/depf51H83uAp1z7i
         DW3qxUtc7anDLPtJtCaTeQY1hHefWTBb+kTC1+gj4oq8+14qMrW4kH0YV4AXnnti93
         hKLUQkf5yBumsoWB7LseExEb25G7+yrJqFju2d8KorAHWv734FoYcD4zsAsw6OV0C8
         sEA4u3Y3ERZWWidrjsdAfLkshyAF7t+VxR29Hawq7VMes5KszhaglymdgRxaVHfUSR
         s0Kk4wCI9BKWlvDfEJSyQnOCmZmQbQS6m1pNQeM6sNEC9v/g3QZYZuPImjxLAHR2PL
         TKeDCjeaIfmNQ==
Date:   Thu, 24 Feb 2022 19:07:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Raghu Bankapur <quic_rbankapu@quicinc.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Krishna Jha <quic_kkishorj@quicinc.com>
Subject: Re: [PATCH V2 1/1] ASoC: compress: propagate the error code from the
 compress framework
Message-ID: <YheKAJtKe5BcFms9@matsya>
References: <cover.1645704570.git.quic_rbankapu@quicinc.com>
 <ca6d05bccf692c7e8ab9aa00f08878f163e524b1.1645704570.git.quic_rbankapu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca6d05bccf692c7e8ab9aa00f08878f163e524b1.1645704570.git.quic_rbankapu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-02-22, 17:48, Raghu Bankapur wrote:
> Propagate the error code from the compress framework for the timestamp
> query. This error code will be used by the client to handle the
> error case scenarios gracefully.


Acked-By: Vinod Koul <vkoul@kernel.org>


-- 
~Vinod
