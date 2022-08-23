Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDF3C25B08
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 04:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbiHWEnc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 00:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiHWEna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DFEBF63
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:43:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41FAA6137C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6EEC433C1;
        Tue, 23 Aug 2022 04:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661229805;
        bh=3+SproVuBpT94Tg43qdo0lGL5IzYEYPl3JCQvNfCEX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gUPx646fuYLdAorPg02kqV3EQDvJw0i5UvMeZn9pxVU5mtOQqbG9sDnVWtAvd+iJM
         Ec433lF8zvN36zPtjvhB5Zhj2JUFmqIT0+9PFOZAlZeU4MBBhCkNJkkospaRmbqEB0
         lyEjOw2Ojo2RoksRqt3El8aihPIGsuFdCoBh7JTuIMIrUKsk8O6l5KfevnSyipwK4V
         xaFV7lkyKCXtUHtwAWTxqE1tIUmbRx7cINidiL7VRn5gX7ta2Q81OXqgoHRDNT8KxA
         X7ByqtH/HHhk30hL7onfFB6Go+kjIWOGL7Kr6XVELifaBPDacOac+5vP9MCx0UmGe4
         TtZf+IJIi5wuw==
Date:   Tue, 23 Aug 2022 04:43:22 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 1/4] platform/chrome: cros_ec_typec: Add bit offset for
 DP VDO
Message-ID: <YwRa6sBS2TVII4gF@google.com>
References: <20220819190807.1275937-1-pmalani@chromium.org>
 <20220819190807.1275937-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819190807.1275937-2-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 07:08:02PM +0000, Prashant Malani wrote:
> Use the right macro while constructing the DP_PORT_VDO to ensure the Pin
> Assignment offsets are correct.
> 
> Fixes: 1ff5d97f070c ("platform/chrome: cros_ec_typec: Register port altmodes")
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

I have no idea but use your judgment:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
