Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D922C4167E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 06:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbiEIGki (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 02:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbiEIGfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:35:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D641116D7
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:31:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DF4AB80EA7
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED84C385AB;
        Mon,  9 May 2022 06:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652077898;
        bh=4TIx1E6FlF7YHG/uNt/9l6SCt1BMcj3v5sx2IOZx3Yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1qvUgiy3z6BACuGLfNCfuvmd14Br6VMFcz9E6HOw0oBZeTaqbLnUe8SC+qj3Akrd
         VVAWT89Zu95U1pp9mxqQN86s3f0bEtgkVn+EfN6ENFIGJ9lMvs+BOq6Q0hhxhuaob7
         fs0CXwiF+pMlkfTp34MMJItBBYnIVLtcvhM3+qBdz9tD6JryGDw+EPbHYHl7MUDU75
         MiZlWPwThCjpVcJEQKJi+MbuF8l7vGfGu7Xjscs46g3E4TQ0rY/jAso79lkmgoOz4J
         CzM80UtZmebacbXuXNlKSVuoUg2hzlY32Y08OBBf8kzpbwuHD6CxfKVvrKCZVjxS2m
         X/mKsbBl84Emw==
Date:   Mon, 9 May 2022 12:01:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 0/3] soundwire: pm runtime improvements
Message-ID: <Yni1Rc1ONlMH82bt@matsya>
References: <20220420023241.14335-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420023241.14335-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-22, 10:32, Bard Liao wrote:
> This series provides a solution to solve a corner case issue where the
> manager device may become pm_runtime active, but without ALSA/ASoC
> requesting any functionality from the peripherals. In this case, the
> hardware peripheral device will report as ATTACHED and its initialization
> routine will be executed. If this initialization routine initiates any
> sort of deferred processing, there is a possibility that the manager could
> suspend without the peripheral suspend sequence being invoked: from the
> pm_runtime framework perspective, the peripheral is *already* suspended.

Applied, thanks

-- 
~Vinod
