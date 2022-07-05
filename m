Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7199FC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 22:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiGEWVl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 18:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiGEWVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:21:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B04F192BC;
        Tue,  5 Jul 2022 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657059699; x=1688595699;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ygLwRkgSYh+haeShLfIUcDBrK9ADdF58dkmlB287494=;
  b=ZzzrVnpwpl5ZD+dcdpD1PkPIosc7mc2PLlttDdpfrDtYYwXq/OPL/6vH
   tQP0JeaEo8bGJyZt2du8eOscndBbpk1J32y2rLV1tVBQJOwgvK8Yr8Lto
   g9yd5fsiDs9cdDNKLljUoWOItrbY43qNWatq/lLUYdLY9FAefKykTniZB
   XoqO1Un+XLQ9elceEAXv38rxemyWq6zkN3zcpAcJu1j5TOnmod/7rBicR
   N/dGAzHEkuwxoO9bXUfRGx3Jcg5SRHFp+Va5PgIezBg63fR/gvWwDY5TW
   FHqwUY7s3n4RMVep48gJsC2olVr/TytZeCO/Wcmqwbpi7ybHdEWQ/aZuG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="263960342"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="263960342"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 15:21:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="567800577"
Received: from vcostago-mobl3.jf.intel.com (HELO vcostago-mobl3) ([10.24.14.91])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 15:21:38 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Colin Foster <colin.foster@in-advantage.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: sched: provide shim definitions for
 taprio_offload_{get,free}
In-Reply-To: <20220704190241.1288847-1-vladimir.oltean@nxp.com>
References: <20220704190241.1288847-1-vladimir.oltean@nxp.com>
Date:   Tue, 05 Jul 2022 15:21:38 -0700
Message-ID: <87pmij6w0d.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> All callers of taprio_offload_get() and taprio_offload_free() prior to
> the blamed commit are conditionally compiled based on CONFIG_NET_SCH_TAPRIO.
>
> felix_vsc9959.c is different; it provides vsc9959_qos_port_tas_set()
> even when taprio is compiled out.
>
> Provide shim definitions for the functions exported by taprio so that
> felix_vsc9959.c is able to compile. vsc9959_qos_port_tas_set() in that
> case is dead code anyway, and ocelot_port->taprio remains NULL, which is
> fine for the rest of the logic.
>
> Fixes: 1c9017e44af2 ("net: dsa: felix: keep reference on entire tc-taprio config")
> Reported-by: Colin Foster <colin.foster@in-advantage.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


-- 
Vinicius
