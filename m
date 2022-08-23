Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FDFC25B08
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 04:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbiHWEnp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 00:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239405AbiHWEnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:43:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8526210FD1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20C4E61384
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D59DC433C1;
        Tue, 23 Aug 2022 04:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661229815;
        bh=wSCy+pZGrLhAu5Ll4vquVklYFYToDjrOBozYb7NQbsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIOHuY9DIFetdETt74nd89OguIJqdEmgcLVfxzYnXHh+j/fvGePO1MfBMI/toTE3/
         Ort96tLJVS0X/m00OkK2/XD+FrgqFMXCsIVe4znv7/OLqw4106vFmezdsXmO0oiJCI
         VzewNzp6MZ7oSqrIPOHNHLnAXtPrdTa0a5UqPgqDZyODtS3pqN79i1ocfS3W6naFKY
         SGCbkCFi/eQlCyjtoNjQqQof3Lhx6rLWcCCLHj+Fj46XUfY/EDx5Qn3sXfiIxF5+mh
         CzM1vb01UJ3JcUVCB/o/ASYXXj3V/nzc1LFxwf8GnWogTKFbkT4kCTW91PdgcSTZjR
         LHraS8p5QWhTg==
Date:   Tue, 23 Aug 2022 04:43:32 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 2/4] platform/chrome: cros_ec_typec: Correct alt mode
 index
Message-ID: <YwRa9PdOfwdlXkKI@google.com>
References: <20220819190807.1275937-1-pmalani@chromium.org>
 <20220819190807.1275937-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819190807.1275937-3-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 07:08:03PM +0000, Prashant Malani wrote:
> Alt mode indices used by USB PD (Power Delivery) start with 1, not 0.
> 
> Update the alt mdoe registration code to factor this in to the alt mode
> descriptor.
> 
> Fixes: de0f49487db3 ("platform/chrome: cros_ec_typec: Register partner altmodes")
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

I have no idea but use your judgment:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
