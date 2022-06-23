Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4703C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 08:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiFWIJf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 04:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiFWIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5500E4739A;
        Thu, 23 Jun 2022 01:09:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E807D61BC2;
        Thu, 23 Jun 2022 08:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4CBC3411B;
        Thu, 23 Jun 2022 08:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655971768;
        bh=9CPwAY0wWTPEXhM/d0JwDJxAObKhi7qi8HFQ+OM2Lhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAEGh09A7pGRhh6u2YW7tgA1dGGMglaktDv7oZgjNbSjzs62Xk5Rl9W4fzz3dfAUI
         qI8HyVkOlkEyZVlYiXzr7NkP4FcrxCGMncjXqUsjXmSRYAYe2k/f3NmRqOtWU7V0Qy
         tY9p8gkNEKeRI8PUmj1e2m9HkV8ZtF0NuT+RRV22TYHhCzecvhPWySaZ3J/SfR88oG
         YqHEV5Jv/7wPKTFZ1otfCdgNIOy958K49uxHh+z2Tdhdn8rIexkXfY/3Sq9FG3WRDu
         R0ErXdifLSnURsVcJYE9WafPjLNWzoYlahAndCeUQJ755kT0D4968kfW3YferCdTs0
         GSFvuA74CbOjQ==
Date:   Thu, 23 Jun 2022 13:39:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Subject: Re: [PATCH v5 0/2] Add software clock gating requirement check
Message-ID: <YrQfs7HUIOV5x8Ub@matsya>
References: <1654863815-3970-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654863815-3970-1-git-send-email-quic_srivasam@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-06-22, 17:53, Srinivasa Rao Mandadapu wrote:
> This patch set is to add software clock gating requirement check

This fails to apply for me, please rebase on sdw-next and resend

Thanks
-- 
~Vinod
