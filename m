Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB6DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 13:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbiDGNn0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 09:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343852AbiDGNnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:43:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61781A183
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649338863; x=1680874863;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Ed54NXbJJI7Rw4e9sYio4n1il0ylHLWLAnh/F3tjv5k=;
  b=AUd6i+gBGL9hpOq3H5VWuBPq9L9A4a6qHMG8LlqwdIHLgYrqEeKXx8Yk
   Uo10RDQraIWbyjOgM5ZgkYShX9yeJOLZe5Tzbx7Axxrdu0DjXLdky2YLs
   Nq1nL+LV8Nlhoc3fRyy1LMD0Q8nFbKs67rUCKgzslqJkLtf/jBKDNmJz1
   6aU2ZElDlHFjYiFlGihGw+sxL+celUBJUJumzrGBPnd/6p/qIonx2bWFs
   CCTiT8y7JeHvcReH8gdIbtBB8XtqHL7yJdkhV1hQswYvijohRN0Ff3GPL
   bi1VYvfnMTY+x1ZzLoJhCVJOhcs/tLCCPKAQSIFe89KKWUoBS2+8xIEVg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10309"; a="241916203"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="asc'?scan'208";a="241916203"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 06:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="asc'?scan'208";a="571055512"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.159.108])
  by orsmga008.jf.intel.com with ESMTP; 07 Apr 2022 06:40:46 -0700
Date:   Thu, 7 Apr 2022 21:20:54 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        Zhi Wang <zhi.a.wang@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Subject: Re: [PATCH v9 1/3] i915/gvt: Separate the MMIO tracking table from
 GVT-g
Message-ID: <20220407132054.GJ1089@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20220407071945.72148-1-zhi.a.wang@intel.com>
 <20220407071945.72148-2-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Content-Disposition: inline
In-Reply-To: <20220407071945.72148-2-zhi.a.wang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022.04.07 03:19:43 -0400, Zhi Wang wrote:
> From: Zhi Wang <zhi.a.wang@gmail.com>
>=20
> To support the new mdev interfaces and the re-factor patches from
> Christoph, which moves the GVT-g code into a dedicated module, the GVT-g
> MMIO tracking table needs to be separated from GVT-g.
>

Looks fine to me. Thanks!

Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYk7lLAAKCRCxBBozTXgY
J6juAJ4/fE3Ex93O/3BhoMK0jebj1njtVwCfXDscbKT5PuPP5NWW0hwjYVTpv44=
=VtR0
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
